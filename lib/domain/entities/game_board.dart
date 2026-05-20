import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/constants/game_constants.dart';
import 'block_piece.dart';

class GameBoard extends Equatable {
  const GameBoard({required this.cells});

  final List<List<Color?>> cells;

  factory GameBoard.empty() {
    return GameBoard(
      cells: List.generate(
        GameConstants.boardSize,
        (_) => List.filled(GameConstants.boardSize, null),
      ),
    );
  }

  bool isInside(int row, int col) {
    return row >= 0 &&
        row < GameConstants.boardSize &&
        col >= 0 &&
        col < GameConstants.boardSize;
  }

  bool canPlace(BlockPiece piece, int anchorRow, int anchorCol) {
    for (final offset in piece.occupiedOffsets) {
      final row = anchorRow + offset.dy.toInt();
      final col = anchorCol + offset.dx.toInt();
      if (!isInside(row, col) || cells[row][col] != null) {
        return false;
      }
    }
    return true;
  }

  GameBoard placePiece(BlockPiece piece, int anchorRow, int anchorCol) {
    final next = cells.map((row) => List<Color?>.from(row)).toList();
    for (final offset in piece.occupiedOffsets) {
      final row = anchorRow + offset.dy.toInt();
      final col = anchorCol + offset.dx.toInt();
      next[row][col] = piece.color;
    }
    return GameBoard(cells: next);
  }

  GameBoard clearLines(Set<int> rows, Set<int> cols) {
    final next = cells.map((row) => List<Color?>.from(row)).toList();

    for (final row in rows) {
      for (var col = 0; col < GameConstants.boardSize; col++) {
        next[row][col] = null;
      }
    }

    for (final col in cols) {
      for (var row = 0; row < GameConstants.boardSize; row++) {
        next[row][col] = null;
      }
    }

    return GameBoard(cells: next);
  }

  bool hasAnyValidPlacement(List<BlockPiece> pieces) {
    for (final piece in pieces) {
      for (var row = 0; row < GameConstants.boardSize; row++) {
        for (var col = 0; col < GameConstants.boardSize; col++) {
          if (canPlace(piece, row, col)) return true;
        }
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [cells];
}
