import 'package:flutter/material.dart';

import '../constants/game_constants.dart';

double boardSizeForWidth(double availableWidth) {
  return availableWidth.clamp(280.0, 420.0);
}

double boardCellSizeForWidth(double availableWidth) {
  return boardSizeForWidth(availableWidth) / GameConstants.boardSize;
}

/// Snaps a piece to the grid cell that is under the user's finger.
///
/// Because the drag anchor is placed at [anchorFraction] of the piece's
/// size, [feedbackTopLeft] (= DragTargetDetails.offset) is offset from
/// the actual finger position. This function reconstructs the finger cell
/// and places the piece so that the correct cell within the piece sits
/// exactly under the finger.
///
/// [feedbackTopLeft] = pointerGlobal − (anchorFraction × pieceSize × cellSize)
({int row, int col}) snapPieceToGrid({
  required Offset boardTopLeft,
  required double cellSize,
  required Offset feedbackTopLeft,
  required int pieceWidth,
  required int pieceHeight,
  double anchorFraction = GameConstants.dragAnchorFraction,
}) {
  final local = feedbackTopLeft - boardTopLeft;

  // Reconstruct which board cell is under the finger.
  final fingerCol = (local.dx / cellSize + anchorFraction * pieceWidth).floor();
  final fingerRow = (local.dy / cellSize + anchorFraction * pieceHeight).floor();

  // The finger lands on cell floor(anchorFraction × pieceSize) within the piece.
  final anchorCellCol = (anchorFraction * pieceWidth).floor();
  final anchorCellRow = (anchorFraction * pieceHeight).floor();

  return (row: fingerRow - anchorCellRow, col: fingerCol - anchorCellCol);
}
