import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/game_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/board_layout.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import 'board_painter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Particle data
// ─────────────────────────────────────────────────────────────────────────────

class _Particle {
  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
    required this.rotationSpeed,
  });

  final double x, y;        // initial position (board-relative pixels)
  final double vx, vy;      // velocity px/s
  final Color color;
  final double size;         // initial half-size in px
  final double rotationSpeed; // rad/s
}

// ─────────────────────────────────────────────────────────────────────────────
// Particle painter
// ─────────────────────────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({
    required this.particles,
    required this.progress, // 0→1 over particle lifetime
  });

  final List<_Particle> particles;
  final double progress; // 0→1

  static const double _lifetime = 0.70; // seconds (must match controller dur)

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress; // 0→1
    if (t <= 0 || particles.isEmpty) return;

    final timeSec = t * _lifetime;

    for (final p in particles) {
      // Position: constant velocity + slight gravity
      final gravity = 180.0; // px/s²
      final px = p.x + p.vx * timeSec;
      final py = p.y + p.vy * timeSec + 0.5 * gravity * timeSec * timeSec;

      // Fade + shrink
      final alpha = (1.0 - t * 1.15).clamp(0.0, 1.0);
      final scale = (1.0 - t * 0.6).clamp(0.0, 1.0);
      if (alpha <= 0 || scale <= 0) continue;

      final s = p.size * scale;
      final angle = p.rotationSpeed * timeSec;

      canvas.save();
      canvas.translate(px, py);
      canvas.rotate(angle);

      // Diamond / rotated square shape
      final path = Path()
        ..moveTo(0, -s)
        ..lineTo(s * 0.65, 0)
        ..lineTo(0, s)
        ..lineTo(-s * 0.65, 0)
        ..close();

      // Glow (blurred larger copy)
      canvas.drawPath(
        path,
        Paint()
          ..color = p.color.withValues(alpha: alpha * 0.45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
      // Bright core
      canvas.drawPath(
        path,
        Paint()
          ..color = Color.lerp(p.color, Colors.white, 0.55)!
              .withValues(alpha: alpha * 0.90),
      );
      // Colored outline
      canvas.drawPath(
        path,
        Paint()
          ..color = p.color.withValues(alpha: alpha * 0.70)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) =>
      progress != old.progress || particles != old.particles;
}

// ─────────────────────────────────────────────────────────────────────────────
// GameBoardView
// ─────────────────────────────────────────────────────────────────────────────

class GameBoardView extends StatefulWidget {
  const GameBoardView({super.key});

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView>
    with TickerProviderStateMixin {
  final _boardKey = GlobalKey();

  // Flash controller drives the BoardPainter clear animation (400 ms).
  late final AnimationController _flashController;
  late final Animation<double> _flashAnim;

  // Particle controller drives the overlay sparkles (700 ms).
  late final AnimationController _particleController;

  List<_Particle> _particles = const [];
  final _rng = math.Random();

  @override
  void initState() {
    super.initState();

    _flashController = AnimationController(
      vsync: this,
      duration: GameConstants.lineClearDuration,
    );
    _flashAnim = CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeInCubic,
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _syncBoardMetrics(BuildContext context) {
    final box = _boardKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    context.read<GameCubit>().updateBoardMetrics(
          topLeft: box.localToGlobal(Offset.zero),
          cellSize: box.size.width / GameConstants.boardSize,
        );
  }

  /// Spawn sparkle particles for every cell in the clearing rows/cols.
  void _spawnParticles(GameState state, double boardSize) {
    final cellSize = boardSize / GameConstants.boardSize;
    final list = <_Particle>[];

    void addCell(int row, int col) {
      final color = state.board.cells[row][col];
      if (color == null) return;
      final cx = (col + 0.5) * cellSize;
      final cy = (row + 0.5) * cellSize;
      _spawnCellParticles(list, cx, cy, color, cellSize);
    }

    for (final row in state.clearingRows) {
      for (var col = 0; col < GameConstants.boardSize; col++) {
        addCell(row, col);
      }
    }
    for (final col in state.clearingCols) {
      for (var row = 0; row < GameConstants.boardSize; row++) {
        if (state.clearingRows.contains(row)) continue; // avoid duplicates
        addCell(row, col);
      }
    }

    _particles = list;
  }

  void _spawnCellParticles(
    List<_Particle> list,
    double cx,
    double cy,
    Color color,
    double cellSize,
  ) {
    const count = 5;
    for (var i = 0; i < count; i++) {
      final angle =
          (i / count) * 2 * math.pi + _rng.nextDouble() * 0.55;
      final speed = (70 + _rng.nextDouble() * 90) * (cellSize / 30.0);
      list.add(_Particle(
        x: cx,
        y: cy,
        vx: math.cos(angle) * speed,
        vy: math.sin(angle) * speed - 30,
        color: color,
        size: cellSize * (0.18 + _rng.nextDouble() * 0.16),
        rotationSpeed: (_rng.nextDouble() - 0.5) * 8,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listenWhen: (prev, next) =>
          prev.status != next.status && next.status == GameStatus.clearing,
      listener: (context, state) {
        // Start flash animation.
        _flashController.forward(from: 0);

        // Spawn particles after a brief delay so they appear when cells flash.
        final box = _boardKey.currentContext?.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          _spawnParticles(state, box.size.width);
          _particleController.forward(from: 0);
        }
      },
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _syncBoardMetrics(context);
        });

        return LayoutBuilder(
          builder: (context, constraints) {
            final boardSize = boardSizeForWidth(constraints.maxWidth);
            final isDark = Theme.of(context).brightness == Brightness.dark;

            return Center(
              child: SizedBox(
                width: boardSize,
                height: boardSize,
                child: Stack(
                  children: [
                    // ── Game board ──────────────────────────────────────
                    SizedBox(
                      key: _boardKey,
                      width: boardSize,
                      height: boardSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedBuilder(
                          animation: _flashAnim,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: BoardPainter(
                                board: state.board,
                                clearingRows: state.clearingRows,
                                clearingCols: state.clearingCols,
                                isDark: isDark,
                                boardBackground:
                                    AppTheme.boardBackground(context),
                                gridColor: AppTheme.boardGrid(context),
                                clearProgress:
                                    state.status == GameStatus.clearing
                                        ? _flashAnim.value
                                        : 0,
                                hoverPiece: state.draggingPiece,
                                hoverRow: state.hoverRow,
                                hoverCol: state.hoverCol,
                              ),
                              size: Size(boardSize, boardSize),
                            );
                          },
                        ),
                      ),
                    ),

                    // ── Particle overlay ────────────────────────────────
                    AnimatedBuilder(
                      animation: _particleController,
                      builder: (context, _) {
                        final progress = _particleController.value;
                        if (progress <= 0 || _particles.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return CustomPaint(
                          painter: _ParticlePainter(
                            particles: _particles,
                            progress: progress,
                          ),
                          size: Size(boardSize, boardSize),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
