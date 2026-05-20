import 'dart:convert';

import 'package:flutter/material.dart';

import '../domain/entities/block_piece.dart';
import '../domain/entities/game_board.dart';
import '../domain/entities/tetromino_type.dart';
import '../features/game/bloc/game_state.dart';

class SavedGameSession {
  const SavedGameSession({
    required this.board,
    required this.trayPieces,
    required this.previewPieces,
    required this.score,
    required this.highScore,
    required this.sessionStartHighScore,
    required this.comboMultiplier,
    required this.difficultyLevel,
    required this.animationSpeed,
    required this.placementsCount,
    required this.piecesGenerated,
  });

  final GameBoard board;
  final List<BlockPiece> trayPieces;
  final List<BlockPiece> previewPieces;
  final int score;
  final int highScore;
  final int sessionStartHighScore;
  final double comboMultiplier;
  final int difficultyLevel;
  final double animationSpeed;
  final int placementsCount;
  final int piecesGenerated;

  factory SavedGameSession.fromState({
    required GameState state,
    required int sessionStartHighScore,
    required int piecesGenerated,
  }) {
    return SavedGameSession(
      board: state.board,
      trayPieces: state.trayPieces,
      previewPieces: state.previewPieces,
      score: state.score,
      highScore: state.highScore,
      sessionStartHighScore: sessionStartHighScore,
      comboMultiplier: state.comboMultiplier,
      difficultyLevel: state.difficultyLevel,
      animationSpeed: state.animationSpeed,
      placementsCount: state.placementsCount,
      piecesGenerated: piecesGenerated,
    );
  }

  GameState toState() {
    return GameState(
      board: board,
      trayPieces: trayPieces,
      previewPieces: previewPieces,
      score: score,
      highScore: highScore,
      comboMultiplier: comboMultiplier,
      status: GameStatus.playing,
      difficultyLevel: difficultyLevel,
      animationSpeed: animationSpeed,
      placementsCount: placementsCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'highScore': highScore,
      'sessionStartHighScore': sessionStartHighScore,
      'comboMultiplier': comboMultiplier,
      'difficultyLevel': difficultyLevel,
      'animationSpeed': animationSpeed,
      'placementsCount': placementsCount,
      'piecesGenerated': piecesGenerated,
      'board': board.cells
          .map((row) => row.map((cell) => cell?.toARGB32()).toList())
          .toList(),
      'trayPieces': trayPieces.map(_pieceToJson).toList(),
      'previewPieces': previewPieces.map(_pieceToJson).toList(),
    };
  }

  factory SavedGameSession.fromJson(Map<String, dynamic> json) {
    final boardCells = (json['board'] as List<dynamic>).map((row) {
      return (row as List<dynamic>)
          .map((value) => value == null ? null : Color(value as int))
          .toList();
    }).toList();

    return SavedGameSession(
      board: GameBoard(cells: boardCells),
      trayPieces: (json['trayPieces'] as List<dynamic>)
          .map((piece) => _pieceFromJson(piece as Map<String, dynamic>))
          .toList(),
      previewPieces: (json['previewPieces'] as List<dynamic>)
          .map((piece) => _pieceFromJson(piece as Map<String, dynamic>))
          .toList(),
      score: json['score'] as int,
      highScore: json['highScore'] as int,
      sessionStartHighScore: json['sessionStartHighScore'] as int,
      comboMultiplier: (json['comboMultiplier'] as num).toDouble(),
      difficultyLevel: json['difficultyLevel'] as int,
      animationSpeed: (json['animationSpeed'] as num).toDouble(),
      placementsCount: json['placementsCount'] as int,
      piecesGenerated: json['piecesGenerated'] as int,
    );
  }

  static Map<String, dynamic> _pieceToJson(BlockPiece piece) {
    return {
      'id': piece.id,
      'type': piece.type.name,
      'cells': piece.cells,
      'color': piece.color.toARGB32(),
    };
  }

  static BlockPiece _pieceFromJson(Map<String, dynamic> json) {
    return BlockPiece(
      id: json['id'] as String,
      type: TetrominoType.values.byName(json['type'] as String),
      cells: (json['cells'] as List<dynamic>)
          .map(
            (row) => (row as List<dynamic>).map((cell) => cell as bool).toList(),
          )
          .toList(),
      color: Color(json['color'] as int),
    );
  }

  static String encode(SavedGameSession session) => jsonEncode(session.toJson());

  static SavedGameSession? decode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return SavedGameSession.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }
}
