import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

import '../../../core/constants/game_constants.dart';
import '../../../data/game_session_storage.dart';
import '../../../data/local_storage_service.dart';
import '../../../domain/entities/block_piece.dart';
import '../../../domain/logic/drag_controller.dart';
import '../../../domain/logic/line_clear_system.dart';
import '../../../domain/logic/random_piece_generator.dart';
import '../../../domain/logic/score_system.dart';
import '../../../presentation/services/sound_service.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required LocalStorageService storage,
    required SoundService soundService,
    Random? random,
  })  : _storage = storage,
        _sound = soundService,
        _generator = RandomPieceGenerator(
          random: (max) => (random ?? Random()).nextInt(max),
        ),
        _lineClearSystem = LineClearSystem(),
        _scoreSystem = ScoreSystem(),
        _dragController = DragController(),
        super(GameState.initial(highScore: storage.getHighScore()));

  final LocalStorageService _storage;
  final SoundService _sound;
  final RandomPieceGenerator _generator;
  final LineClearSystem _lineClearSystem;
  final ScoreSystem _scoreSystem;
  final DragController _dragController;

  Offset _boardTopLeft = Offset.zero;
  double _boardCellSize = 0;
  int _sessionStartHighScore = 0;

  void updateBoardMetrics({
    required Offset topLeft,
    required double cellSize,
  }) {
    _boardTopLeft = topLeft;
    _boardCellSize = cellSize;
  }

  void updateHoverFromPointer(Offset globalPosition) {
    updateHover(
      boardTopLeft: _boardTopLeft,
      cellSize: _boardCellSize,
      dragCenter: globalPosition,
    );
  }

  void clearHoverPreview() {
    if (state.hoverRow == null && state.hoverCol == null) return;
    emit(state.copyWith(clearHover: true));
  }

  Future<void> startGame() async {
    _sessionStartHighScore = _storage.getHighScore();
    _generator.restoreGenerationCount(0);
    await _storage.clearSavedGame();
    final batch = _generator.nextBatch(GameConstants.initialQueueSize);
    emit(
      GameState.initial(highScore: _storage.getHighScore()).copyWith(
        trayPieces: batch.take(GameConstants.trayPieceCount).toList(),
        previewPieces: batch
            .skip(GameConstants.trayPieceCount)
            .take(GameConstants.previewCount)
            .toList(),
      ),
    );
  }

  Future<void> continueSavedGame() async {
    final saved = _storage.loadSavedGame();
    if (saved == null) {
      await startGame();
      return;
    }

    _sessionStartHighScore = saved.sessionStartHighScore;
    _generator.restoreGenerationCount(saved.piecesGenerated);
    emit(saved.toState());
  }

  Future<void> saveProgressAndExit() async {
    if (state.status == GameStatus.gameOver) return;

    final session = SavedGameSession.fromState(
      state: state,
      sessionStartHighScore: _sessionStartHighScore,
      piecesGenerated: _generator.piecesGenerated,
    );
    await _storage.saveSavedGame(session);
  }

  Future<void> discardProgressAndExit() async {
    await _storage.saveHighScore(_sessionStartHighScore);
    await _storage.clearSavedGame();
  }

  void startDrag(String pieceId) {
    if (state.status != GameStatus.playing) return;
    emit(state.copyWith(draggingPieceId: pieceId, clearHover: true));
    _sound.playPickup();
  }

  void updateHover({
    required Offset boardTopLeft,
    required double cellSize,
    required Offset dragCenter,
  }) {
    if (state.status != GameStatus.playing) return;
    final piece = state.draggingPiece;
    if (piece == null) return;

    final snap = _dragController.snapToGrid(
      boardTopLeft: boardTopLeft,
      cellSize: cellSize,
      piece: piece,
      dragCenter: dragCenter,
      board: state.board,
    );

    emit(
      state.copyWith(
        hoverRow: snap?.row,
        hoverCol: snap?.col,
        clearHover: snap == null,
      ),
    );
  }

  void cancelDrag() {
    emit(state.copyWith(clearDrag: true, clearHover: true));
  }

  Future<void> tryDropDraggingPiece() async {
    final pieceId = state.draggingPieceId;
    if (pieceId == null || state.status != GameStatus.playing) return;

    if (state.hoverRow != null && state.hoverCol != null) {
      await _placePieceAt(
        pieceId: pieceId,
        row: state.hoverRow!,
        col: state.hoverCol!,
      );
      return;
    }

    cancelDrag();
    _sound.playInvalid();
  }

  Future<void> dropPiece({
    required String pieceId,
    required Offset boardTopLeft,
    required double cellSize,
    required Offset dragCenter,
  }) async {
    if (state.status != GameStatus.playing) return;

    final pieceIndex = state.trayPieces.indexWhere((p) => p.id == pieceId);
    if (pieceIndex == -1) {
      emit(state.copyWith(clearDrag: true, clearHover: true));
      return;
    }

    final piece = state.trayPieces[pieceIndex];
    final snap = _dragController.snapToGrid(
      boardTopLeft: boardTopLeft,
      cellSize: cellSize,
      piece: piece,
      dragCenter: dragCenter,
      board: state.board,
    );

    if (snap == null) {
      emit(state.copyWith(clearDrag: true, clearHover: true));
      _sound.playInvalid();
      return;
    }

    await _placePieceAt(pieceId: pieceId, row: snap.row, col: snap.col);
  }

  Future<void> _placePieceAt({
    required String pieceId,
    required int row,
    required int col,
  }) async {
    if (state.status != GameStatus.playing) return;

    final pieceIndex = state.trayPieces.indexWhere((p) => p.id == pieceId);
    if (pieceIndex == -1) {
      emit(state.copyWith(clearDrag: true, clearHover: true));
      return;
    }

    final piece = state.trayPieces[pieceIndex];
    if (!state.board.canPlace(piece, row, col)) {
      emit(state.copyWith(clearDrag: true, clearHover: true));
      _sound.playInvalid();
      return;
    }

    var board = state.board.placePiece(piece, row, col);
    final clearResult = _lineClearSystem.detect(board);

    var score = state.score + _scoreSystem.placementBonus(piece.occupiedOffsets.length);
    var combo = state.comboMultiplier;
    var lastGain = _scoreSystem.placementBonus(piece.occupiedOffsets.length);

    if (clearResult.hasClears) {
      final scoreResult = _scoreSystem.applyClear(
        linesCleared: clearResult.totalLines,
        currentComboMultiplier: combo,
        difficultyLevel: state.difficultyLevel,
      );
      score += scoreResult.pointsEarned;
      combo = scoreResult.nextComboMultiplier;
      lastGain += scoreResult.pointsEarned;

      emit(
        state.copyWith(
          board: board,
          score: score,
          comboMultiplier: combo,
          status: GameStatus.clearing,
          clearingRows: clearResult.clearedRows,
          clearingCols: clearResult.clearedCols,
          lastScoreGain: lastGain,
          clearDrag: true,
          clearHover: true,
        ),
      );

      _sound.playClear();
      await _vibrate(clearResult.totalLines);

      final clearDuration = _scaledDuration(GameConstants.lineClearDuration);
      await Future<void>.delayed(clearDuration);

      board = board.clearLines(clearResult.clearedRows, clearResult.clearedCols);
    } else {
      combo = 1.0;
      _sound.playPlace();
    }

    final nextTray = List<BlockPiece>.from(state.trayPieces)..removeAt(pieceIndex);
    final nextPreview = List<BlockPiece>.from(state.previewPieces);

    while (nextTray.length < GameConstants.trayPieceCount) {
      if (nextPreview.isNotEmpty) {
        nextTray.add(nextPreview.removeAt(0));
      } else {
        nextTray.add(_generator.next());
      }
    }

    while (nextPreview.length < GameConstants.previewCount) {
      nextPreview.add(_generator.next());
    }

    final placements = state.placementsCount + 1;
    final difficulty = (_generator.piecesGenerated / 15).floor();
    final animSpeed = (1.0 + difficulty * 0.08).clamp(1.0, 2.0);

    var highScore = state.highScore;
    if (score > highScore) {
      highScore = score;
      await _storage.saveHighScore(highScore);
    }

    final canContinue = board.hasAnyValidPlacement(nextTray);

    emit(
      state.copyWith(
        board: board,
        trayPieces: nextTray,
        previewPieces: nextPreview,
        score: score,
        highScore: highScore,
        comboMultiplier: combo,
        status: canContinue ? GameStatus.playing : GameStatus.gameOver,
        difficultyLevel: difficulty,
        animationSpeed: animSpeed,
        clearingRows: const {},
        clearingCols: const {},
        lastScoreGain: lastGain,
        placementsCount: placements,
        clearDrag: true,
        clearHover: true,
      ),
    );

    if (!canContinue) {
      await _storage.clearSavedGame();
      _sound.playGameOver();
      await _vibrate(2);
    }
  }

  void rotatePiece(String pieceId) {
    if (state.status != GameStatus.playing) return;

    final tray = state.trayPieces.map((piece) {
      if (piece.id == pieceId) return piece.rotated();
      return piece;
    }).toList();

    emit(state.copyWith(trayPieces: tray));
    _sound.playRotate();
  }

  void rotateDraggingPiece() {
    final piece = state.draggingPiece;
    if (piece == null) return;
    rotatePiece(piece.id);
  }

  Duration _scaledDuration(Duration base) {
    return Duration(
      milliseconds: (base.inMilliseconds / state.animationSpeed).round().clamp(
            GameConstants.minAnimationDuration.inMilliseconds,
            base.inMilliseconds,
          ),
    );
  }

  Future<void> _vibrate(int intensity) async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != true) return;
    await Vibration.vibrate(duration: 20 + intensity * 15);
  }
}
