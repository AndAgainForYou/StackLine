import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

class _Piece {
  _Piece({
    required this.cells,
    required this.color,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.cellSize,
  });

  final List<List<bool>> cells;
  final Color color;
  double x;
  double y;
  final double vx;
  final double vy;
  final double cellSize;

  int get cols => cells.isEmpty ? 0 : cells.first.length;
  int get rows => cells.length;
  double get pixelWidth => cols * cellSize;
  double get pixelHeight => rows * cellSize;
}

// ---------------------------------------------------------------------------
// Shapes & colours (reuses same look as the game)
// ---------------------------------------------------------------------------

const _shapes = [
  // i
  [
    [true, true, true, true],
  ],
  // o
  [
    [true, true],
    [true, true],
  ],
  // t
  [
    [false, true, false],
    [true, true, true],
  ],
  // s
  [
    [false, true, true],
    [true, true, false],
  ],
  // z
  [
    [true, true, false],
    [false, true, true],
  ],
  // j
  [
    [true, false, false],
    [true, true, true],
  ],
  // l
  [
    [false, false, true],
    [true, true, true],
  ],
  // bigL
  [
    [true, false],
    [true, false],
    [true, true],
  ],
  // cross
  [
    [false, true, false],
    [true, true, true],
    [false, true, false],
  ],
];

const _colors = [
  Color(0xFF00E5FF), // i
  Color(0xFFFFD600), // o
  Color(0xFFAA00FF), // t
  Color(0xFF00E676), // s
  Color(0xFFFF5252), // z
  Color(0xFF448AFF), // j
  Color(0xFFFF9100), // l
  Color(0xFF7C4DFF), // bigL
  Color(0xFFFF4081), // cross
];

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class HomeBackground extends StatefulWidget {
  const HomeBackground({super.key, this.pieceCount = 12});

  final int pieceCount;

  @override
  State<HomeBackground> createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends State<HomeBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _last = Duration.zero;
  final List<_Piece> _pieces = [];
  Size _size = Size.zero;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _init(Size size) {
    if (_initialized && _size == size) return;
    _size = size;
    _initialized = true;
    _pieces
      ..clear()
      ..addAll(_buildPieces(size));
  }

  List<_Piece> _buildPieces(Size size) {
    final rng = math.Random();
    const minSpeed = 12.0;
    const maxSpeed = 28.0;
    const minCell = 16.0;
    const maxCell = 28.0;

    return List.generate(widget.pieceCount, (_) {
      final idx = rng.nextInt(_shapes.length);
      final cells = _shapes[idx];
      final color = _colors[idx];
      final cellSize = minCell + rng.nextDouble() * (maxCell - minCell);

      final speed = minSpeed + rng.nextDouble() * (maxSpeed - minSpeed);
      final angle = rng.nextDouble() * 2 * math.pi;
      final vx = math.cos(angle) * speed;
      final vy = math.sin(angle) * speed;

      final cols = cells.first.length;
      final rows = cells.length;

      return _Piece(
        cells: cells,
        color: color,
        x: rng.nextDouble() * (size.width - cols * cellSize),
        y: rng.nextDouble() * (size.height - rows * cellSize),
        vx: vx,
        vy: vy,
        cellSize: cellSize,
      );
    });
  }

  void _onTick(Duration elapsed) {
    if (!mounted) return;
    if (_last == Duration.zero || !_initialized) {
      _last = elapsed;
      return;
    }

    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;

    for (final p in _pieces) {
      p.x += p.vx * dt;
      p.y += p.vy * dt;

      // wrap horizontally
      if (p.vx > 0 && p.x > _size.width) {
        p.x = -p.pixelWidth;
      } else if (p.vx < 0 && p.x + p.pixelWidth < 0) {
        p.x = _size.width;
      }
      // wrap vertically
      if (p.vy > 0 && p.y > _size.height) {
        p.y = -p.pixelHeight;
      } else if (p.vy < 0 && p.y + p.pixelHeight < 0) {
        p.y = _size.height;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _init(size);
        return CustomPaint(
          size: size,
          painter: _BackgroundPainter(pieces: _pieces, isDark: isDark),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Painter
// ---------------------------------------------------------------------------

class _BackgroundPainter extends CustomPainter {
  _BackgroundPainter({required this.pieces, required this.isDark});

  final List<_Piece> pieces;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      _drawPiece(canvas, p);
    }
  }

  void _drawPiece(Canvas canvas, _Piece p) {
    final alpha = isDark ? 0.30 : 0.11;
    final paint = Paint()
      ..color = p.color.withValues(alpha: alpha)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = p.color.withValues(alpha: alpha * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const padding = 1.5;
    final radius = Radius.circular(p.cellSize * 0.18);

    for (var row = 0; row < p.rows; row++) {
      for (var col = 0; col < p.cols; col++) {
        if (!p.cells[row][col]) continue;

        final rect = Rect.fromLTWH(
          p.x + col * p.cellSize + padding,
          p.y + row * p.cellSize + padding,
          p.cellSize - padding * 2,
          p.cellSize - padding * 2,
        );
        final rrect = RRect.fromRectAndRadius(rect, radius);
        canvas.drawRRect(rrect, paint);
        canvas.drawRRect(rrect, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) =>
      old.pieces != pieces || old.isDark != isDark;
}
