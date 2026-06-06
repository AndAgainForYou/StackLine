import 'package:flutter/material.dart';

import '../constants/game_constants.dart';

double boardSizeForWidth(double availableWidth) {
  return availableWidth.clamp(280.0, 420.0);
}

double boardCellSizeForWidth(double availableWidth) {
  return boardSizeForWidth(availableWidth) / GameConstants.boardSize;
}

/// Snaps a piece to the grid cell that best aligns with the user's finger.
///
/// [feedbackTopLeft] = DragTargetDetails.offset = top-left of the feedback
/// widget in global coordinates. The anchor fractions describe where within
/// the piece the finger sits:
///   X: 0.5  → piece centred horizontally on finger
///   Y: 1.0  → finger at bottom edge of piece (piece entirely above finger)
({int row, int col}) snapPieceToGrid({
  required Offset boardTopLeft,
  required double cellSize,
  required Offset feedbackTopLeft,
  required int pieceWidth,
  required int pieceHeight,
  double anchorFractionX = GameConstants.dragAnchorFractionX,
  double anchorFractionY = GameConstants.dragAnchorFractionY,
}) {
  final local = feedbackTopLeft - boardTopLeft;

  // Reconstruct which board cell is under the finger.
  final fingerCol =
      (local.dx / cellSize + anchorFractionX * pieceWidth).floor();
  final fingerRow =
      (local.dy / cellSize + anchorFractionY * pieceHeight).floor();

  // Compute how many cells the anchor is offset from the piece's top-left.
  // No clamping: anchor fractions > 1.0 simply shift the piece further
  // away from the finger, which is what allows values like 1.2 to work.
  final anchorCellCol = (anchorFractionX * pieceWidth).floor();
  final anchorCellRow = (anchorFractionY * pieceHeight).floor();

  return (row: fingerRow - anchorCellRow, col: fingerCol - anchorCellCol);
}
