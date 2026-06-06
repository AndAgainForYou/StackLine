import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/game_constants.dart';
import '../../domain/entities/block_piece.dart';
import '../../domain/entities/game_board.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BoardPainter
// ─────────────────────────────────────────────────────────────────────────────

class BoardPainter extends CustomPainter {
  BoardPainter({
    required this.board,
    this.clearingRows = const {},
    this.clearingCols = const {},
    required this.isDark,
    required this.boardBackground,
    required this.gridColor,
    /// 0 = idle, 0→1 during clear animation.
    this.clearProgress = 0.0,
    this.hoverPiece,
    this.hoverRow,
    this.hoverCol,
  });

  final GameBoard board;
  final Set<int> clearingRows;
  final Set<int> clearingCols;
  final bool isDark;
  final Color boardBackground;
  final Color gridColor;
  final double clearProgress;
  final BlockPiece? hoverPiece;
  final int? hoverRow;
  final int? hoverCol;

  static const int _n = GameConstants.boardSize;

  // ── Hover helpers ─────────────────────────────────────────────────────────

  Set<(int, int)> get _hoverCells {
    if (hoverPiece == null || hoverRow == null || hoverCol == null) {
      return const {};
    }
    return {
      for (final o in hoverPiece!.occupiedOffsets)
        (hoverRow! + o.dy.toInt(), hoverCol! + o.dx.toInt()),
    };
  }

  ({Set<int> rows, Set<int> cols}) _wouldClear(Set<(int, int)> hovered) {
    if (hovered.isEmpty) return (rows: const {}, cols: const {});
    final rows = <int>{};
    final cols = <int>{};

    for (var r = 0; r < _n; r++) {
      var full = true;
      for (var c = 0; c < _n; c++) {
        if (board.cells[r][c] == null && !hovered.contains((r, c))) {
          full = false;
          break;
        }
      }
      if (full) rows.add(r);
    }
    for (var c = 0; c < _n; c++) {
      var full = true;
      for (var r = 0; r < _n; r++) {
        if (board.cells[r][c] == null && !hovered.contains((r, c))) {
          full = false;
          break;
        }
      }
      if (full) cols.add(c);
    }
    return (rows: rows, cols: cols);
  }

  // ── Paint ─────────────────────────────────────────────────────────────────

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / _n;
    final radius = cellSize * 0.12;
    final padding = cellSize * 0.06;

    // Background
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius * 2)),
      Paint()..color = boardBackground,
    );

    final hovered = _hoverCells;
    final clearing = hovered.isEmpty
        ? (rows: <int>{}, cols: <int>{})
        : _wouldClear(hovered);

    // ── Cells ──
    for (var row = 0; row < _n; row++) {
      for (var col = 0; col < _n; col++) {
        final rect = Rect.fromLTWH(
          col * cellSize + padding,
          row * cellSize + padding,
          cellSize - padding * 2,
          cellSize - padding * 2,
        );

        final isClearing =
            clearingRows.contains(row) || clearingCols.contains(col);
        final color = board.cells[row][col];
        final isHovered = hovered.contains((row, col));
        final wouldClear =
            clearing.rows.contains(row) || clearing.cols.contains(col);

        if (isHovered) {
          _drawPreviewBlock(canvas, rect, hoverPiece!.color, radius, wouldClear);
        } else if (isClearing && color != null) {
          // Wave delay: rows clear L→R, cols clear T→B.
          // Both: take the smaller (earlier) delay.
          const maxDelay = 0.40;
          double delay = maxDelay;
          if (clearingRows.contains(row)) {
            delay = math.min(delay, col / (_n - 1) * maxDelay);
          }
          if (clearingCols.contains(col)) {
            delay = math.min(delay, row / (_n - 1) * maxDelay);
          }
          final localT =
              ((clearProgress - delay) / (1.0 - maxDelay)).clamp(0.0, 1.0);
          _drawClearingBlock(canvas, rect, color, radius, localT);
        } else if (color != null) {
          _drawBlock(canvas, rect, color, radius,
              dimmed: wouldClear && hovered.isNotEmpty);
        } else {
          final gridAlpha = (wouldClear && hovered.isNotEmpty) ? 0.70 : 0.45;
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(radius)),
            Paint()..color = gridColor.withValues(alpha: gridAlpha),
          );
        }
      }
    }

    // ── Sweep glow strip (moves L→R / T→B ahead of the wave front) ──
    if (clearProgress > 0 && clearProgress < 0.90) {
      _drawSweepGlow(canvas, size, cellSize);
    }
  }

  /// A bright vertical (or horizontal) "laser" that leads the clear wave.
  void _drawSweepGlow(Canvas canvas, Size size, double cellSize) {
    // Wave front position: the column/row that is just being hit.
    const maxDelay = 0.40;
    // sweepFront ∈ [0..1] tracks the leading edge of the wave.
    final sweepFront = (clearProgress / (1.0 - maxDelay + maxDelay))
        .clamp(0.0, 1.0);

    final glowAlpha = math.sin(sweepFront * math.pi) * 0.35;
    if (glowAlpha <= 0) return;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Draw a strip at the current wave front for each clearing row.
    for (final row in clearingRows) {
      final x = sweepFront * size.width;
      paint.color = Colors.white.withValues(alpha: glowAlpha);
      canvas.drawRect(
        Rect.fromLTWH(x - cellSize * 0.8, row * cellSize, cellSize * 1.6,
            cellSize),
        paint,
      );
    }

    // For clearing cols.
    for (final col in clearingCols) {
      final y = sweepFront * size.height;
      paint.color = Colors.white.withValues(alpha: glowAlpha);
      canvas.drawRect(
        Rect.fromLTWH(col * cellSize, y - cellSize * 0.8, cellSize,
            cellSize * 1.6),
        paint,
      );
    }
  }

  // ── Block renderers ───────────────────────────────────────────────────────

  /// Animated clearing block.
  ///
  /// [localT] ∈ [0,1] is the per-cell progress after its wave delay:
  ///  • 0.00–0.35 : flash to white (explosion)
  ///  • 0.35–1.00 : scale down + rotate + fade (disappear)
  void _drawClearingBlock(
      Canvas canvas, Rect rect, Color baseColor, double radius, double localT) {
    const phaseFlash = 0.35;

    if (localT <= 0) {
      // Not started yet: draw normally.
      _drawBlock(canvas, rect, baseColor, radius);
      return;
    }

    if (localT <= phaseFlash) {
      final t = localT / phaseFlash; // 0→1
      // Slight scale-up (punch) at t=0.5, then settle.
      final punch = 1.0 + math.sin(t * math.pi) * 0.12;
      final scaledRect = Rect.fromCenter(
        center: rect.center,
        width: rect.width * punch,
        height: rect.height * punch,
      );
      final color = Color.lerp(baseColor, Colors.white, t * 0.85) ?? baseColor;
      _drawBlock(canvas, scaledRect, color, radius * punch);
    } else {
      final t = (localT - phaseFlash) / (1.0 - phaseFlash); // 0→1
      final scale = (1.0 - t).clamp(0.0, 1.0);
      final alpha = (1.0 - t * 1.1).clamp(0.0, 1.0);
      if (scale <= 0 || alpha <= 0) return;

      final scaledRect = Rect.fromCenter(
        center: rect.center,
        width: rect.width * scale,
        height: rect.height * scale,
      );
      final scaledRadius = radius * scale;
      final rrect =
          RRect.fromRectAndRadius(scaledRect, Radius.circular(scaledRadius));

      // Core: bright white fading out.
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = Colors.white.withValues(alpha: alpha * 0.92)
          ..style = PaintingStyle.fill,
      );
      // Colored halo around it.
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = baseColor.withValues(alpha: alpha * 0.55)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  void _drawBlock(Canvas canvas, Rect rect, Color color, double radius,
      {bool dimmed = false}) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = color.withValues(alpha: dimmed ? 0.55 : 0.95)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white.withValues(alpha: isDark ? 0.12 : 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    if (!dimmed) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
              rect.left + 2, rect.top + 2, rect.width * 0.45, rect.height * 0.25),
          Radius.circular(radius * 0.5),
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.15),
      );
    }
  }

  void _drawPreviewBlock(
      Canvas canvas, Rect rect, Color color, double radius, bool wouldClear) {
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = color.withValues(alpha: wouldClear ? 0.75 : 0.45)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = color.withValues(alpha: 0.95)
        ..style = PaintingStyle.stroke
        ..strokeWidth = wouldClear ? 2.0 : 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant BoardPainter old) =>
      board != old.board ||
      clearingRows != old.clearingRows ||
      clearingCols != old.clearingCols ||
      clearProgress != old.clearProgress ||
      hoverPiece != old.hoverPiece ||
      hoverRow != old.hoverRow ||
      hoverCol != old.hoverCol;
}

// ─────────────────────────────────────────────────────────────────────────────
// PiecePainter  (unchanged)
// ─────────────────────────────────────────────────────────────────────────────

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
  bool shouldRepaint(covariant PiecePainter old) =>
      piece != old.piece || cellSize != old.cellSize || opacity != old.opacity;
}
