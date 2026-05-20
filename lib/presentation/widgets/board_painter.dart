import 'package:flutter/material.dart';

import '../../core/constants/game_constants.dart';
import '../../domain/entities/block_piece.dart';
import '../../domain/entities/game_board.dart';

class BoardPainter extends CustomPainter {
  BoardPainter({
    required this.board,
    this.clearingRows = const {},
    this.clearingCols = const {},
    required this.isDark,
    required this.boardBackground,
    required this.gridColor,
    this.clearFlash = 1.0,
  });

  final GameBoard board;
  final Set<int> clearingRows;
  final Set<int> clearingCols;
  final bool isDark;
  final Color boardBackground;
  final Color gridColor;
  final double clearFlash;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / GameConstants.boardSize;
    final radius = cellSize * 0.12;
    final padding = cellSize * 0.06;

    final bgRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius * 2),
    );
    canvas.drawRRect(bgRect, Paint()..color = boardBackground);

    for (var row = 0; row < GameConstants.boardSize; row++) {
      for (var col = 0; col < GameConstants.boardSize; col++) {
        final rect = Rect.fromLTWH(
          col * cellSize + padding,
          row * cellSize + padding,
          cellSize - padding * 2,
          cellSize - padding * 2,
        );

        final isClearing =
            clearingRows.contains(row) || clearingCols.contains(col);
        final color = board.cells[row][col];

        if (color != null) {
          _drawBlock(
            canvas,
            rect,
            isClearing ? _flashColor(color) : color,
            radius,
          );
        } else {
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(radius)),
            Paint()..color = gridColor.withValues(alpha: 0.45),
          );
        }
      }
    }
  }

  Color _flashColor(Color base) {
    return Color.lerp(base, Colors.white, clearFlash * 0.65) ?? base;
  }

  void _drawBlock(Canvas canvas, Rect rect, Color color, double radius) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = color.withValues(alpha: 0.95)
        ..style = PaintingStyle.fill,
    );

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white.withValues(alpha: isDark ? 0.12 : 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    final highlight = Rect.fromLTWH(
      rect.left + 2,
      rect.top + 2,
      rect.width * 0.45,
      rect.height * 0.25,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(highlight, Radius.circular(radius * 0.5)),
      Paint()..color = Colors.white.withValues(alpha: 0.15),
    );
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return board != oldDelegate.board ||
        clearingRows != oldDelegate.clearingRows ||
        clearingCols != oldDelegate.clearingCols ||
        clearFlash != oldDelegate.clearFlash;
  }
}

class PiecePainter extends CustomPainter {
  PiecePainter({
    required this.piece,
    required this.cellSize,
    this.opacity = 1.0,
  });

  final BlockPiece piece;
  final double cellSize;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final padding = cellSize * 0.06;
    final radius = cellSize * 0.12;

    for (final offset in piece.occupiedOffsets) {
      final rect = Rect.fromLTWH(
        offset.dx * cellSize + padding,
        offset.dy * cellSize + padding,
        cellSize - padding * 2,
        cellSize - padding * 2,
      );

      final color = piece.color.withValues(alpha: opacity);
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

      canvas.drawRRect(rrect, Paint()..color = color);
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PiecePainter oldDelegate) {
    return piece != oldDelegate.piece ||
        cellSize != oldDelegate.cellSize ||
        opacity != oldDelegate.opacity;
  }
}
