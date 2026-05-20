import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/game_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/board_layout.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import 'board_painter.dart';

class GameBoardView extends StatefulWidget {
  const GameBoardView({super.key});

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView>
    with SingleTickerProviderStateMixin {
  final _boardKey = GlobalKey();
  late AnimationController _flashController;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: GameConstants.lineClearDuration,
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listenWhen: (prev, next) =>
          prev.status != next.status && next.status == GameStatus.clearing,
      listener: (_, __) {
        _flashController.forward(from: 0);
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
                key: _boardKey,
                width: boardSize,
                height: boardSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedBuilder(
                    animation: _flashController,
                    builder: (context, _) {
                      return CustomPaint(
                        painter: BoardPainter(
                          board: state.board,
                          clearingRows: state.clearingRows,
                          clearingCols: state.clearingCols,
                          isDark: isDark,
                          boardBackground: AppTheme.boardBackground(context),
                          gridColor: AppTheme.boardGrid(context),
                          clearFlash: state.status == GameStatus.clearing
                              ? _flashController.value
                              : 0,
                        ),
                        size: Size(boardSize, boardSize),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
