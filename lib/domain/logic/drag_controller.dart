import 'package:flutter/material.dart';

import '../entities/block_piece.dart';
import '../entities/game_board.dart';
import '../../core/utils/board_layout.dart';

class DragController {
  const DragController();

  ({int row, int col})? snapToGrid({
    required Offset boardTopLeft,
    required double cellSize,
    required BlockPiece piece,
    required Offset dragCenter, // = DragTargetDetails.offset = feedbackTopLeft
    required GameBoard board,
  }) {
    final snap = snapPieceToGrid(
      boardTopLeft: boardTopLeft,
      cellSize: cellSize,
      feedbackTopLeft: dragCenter,
      pieceWidth: piece.width,
      pieceHeight: piece.height,
    );

    if (board.canPlace(piece, snap.row, snap.col)) {
      return snap;
    }
    return null;
  }

  bool isValidPlacement({
    required GameBoard board,
    required BlockPiece piece,
    required int row,
    required int col,
  }) {
    return board.canPlace(piece, row, col);
  }
}
