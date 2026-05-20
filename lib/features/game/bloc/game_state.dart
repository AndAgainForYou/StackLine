import 'package:equatable/equatable.dart';

import '../../../domain/entities/block_piece.dart';
import '../../../domain/entities/game_board.dart';

enum GameStatus { playing, clearing, gameOver }

class GameState extends Equatable {
  const GameState({
    required this.board,
    required this.trayPieces,
    required this.previewPieces,
    required this.score,
    required this.highScore,
    required this.comboMultiplier,
    required this.status,
    required this.difficultyLevel,
    required this.animationSpeed,
    this.draggingPieceId,
    this.hoverRow,
    this.hoverCol,
    this.clearingRows = const {},
    this.clearingCols = const {},
    this.lastScoreGain,
    this.placementsCount = 0,
  });

  factory GameState.initial({required int highScore}) {
    return GameState(
      board: GameBoard.empty(),
      trayPieces: const [],
      previewPieces: const [],
      score: 0,
      highScore: highScore,
      comboMultiplier: 1.0,
      status: GameStatus.playing,
      difficultyLevel: 0,
      animationSpeed: 1.0,
    );
  }

  final GameBoard board;
  final List<BlockPiece> trayPieces;
  final List<BlockPiece> previewPieces;
  final int score;
  final int highScore;
  final double comboMultiplier;
  final GameStatus status;
  final int difficultyLevel;
  final double animationSpeed;
  final String? draggingPieceId;
  final int? hoverRow;
  final int? hoverCol;
  final Set<int> clearingRows;
  final Set<int> clearingCols;
  final int? lastScoreGain;
  final int placementsCount;

  bool get isDragging => draggingPieceId != null;

  bool get hasProgress {
    if (score > 0 || placementsCount > 0) return true;
    for (final row in board.cells) {
      for (final cell in row) {
        if (cell != null) return true;
      }
    }
    return false;
  }

  bool get needsExitConfirmation =>
      status != GameStatus.gameOver && hasProgress;

  BlockPiece? get draggingPiece {
    if (draggingPieceId == null) return null;
    for (final piece in trayPieces) {
      if (piece.id == draggingPieceId) return piece;
    }
    return null;
  }

  GameState copyWith({
    GameBoard? board,
    List<BlockPiece>? trayPieces,
    List<BlockPiece>? previewPieces,
    int? score,
    int? highScore,
    double? comboMultiplier,
    GameStatus? status,
    int? difficultyLevel,
    double? animationSpeed,
    String? draggingPieceId,
    int? hoverRow,
    int? hoverCol,
    Set<int>? clearingRows,
    Set<int>? clearingCols,
    int? lastScoreGain,
    int? placementsCount,
    bool clearDrag = false,
    bool clearHover = false,
    bool clearLastScoreGain = false,
  }) {
    return GameState(
      board: board ?? this.board,
      trayPieces: trayPieces ?? this.trayPieces,
      previewPieces: previewPieces ?? this.previewPieces,
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      comboMultiplier: comboMultiplier ?? this.comboMultiplier,
      status: status ?? this.status,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      draggingPieceId:
          clearDrag ? null : draggingPieceId ?? this.draggingPieceId,
      hoverRow: clearHover ? null : hoverRow ?? this.hoverRow,
      hoverCol: clearHover ? null : hoverCol ?? this.hoverCol,
      clearingRows: clearingRows ?? this.clearingRows,
      clearingCols: clearingCols ?? this.clearingCols,
      lastScoreGain: clearLastScoreGain
          ? null
          : lastScoreGain ?? this.lastScoreGain,
      placementsCount: placementsCount ?? this.placementsCount,
    );
  }

  @override
  List<Object?> get props => [
        board,
        trayPieces,
        previewPieces,
        score,
        highScore,
        comboMultiplier,
        status,
        difficultyLevel,
        animationSpeed,
        draggingPieceId,
        hoverRow,
        hoverCol,
        clearingRows,
        clearingCols,
        lastScoreGain,
        placementsCount,
      ];
}
