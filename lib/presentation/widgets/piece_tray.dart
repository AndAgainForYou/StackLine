import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/game_constants.dart';
import '../../core/utils/board_layout.dart';
import '../../domain/entities/block_piece.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import '../../l10n/app_localizations.dart';
import 'board_painter.dart';

class DraggablePiece extends StatelessWidget {
  const DraggablePiece({
    super.key,
    required this.piece,
    required this.trayCellSize,
    required this.boardCellSize,
    required this.enabled,
  });

  final BlockPiece piece;
  final double trayCellSize;
  final double boardCellSize;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final trayWidth = piece.width * trayCellSize;
    final trayHeight = piece.height * trayCellSize;
    final boardWidth = piece.width * boardCellSize;
    final boardHeight = piece.height * boardCellSize;

    final child = SizedBox(
      width: trayWidth,
      height: trayHeight,
      child: CustomPaint(
        painter: PiecePainter(piece: piece, cellSize: trayCellSize),
      ),
    );

    if (!enabled) {
      return Opacity(opacity: 0.35, child: child);
    }

    return Draggable<BlockPiece>(
      data: piece,
      maxSimultaneousDrags: 1,
      dragAnchorStrategy: (_, __, ___) => Offset(
        boardWidth * GameConstants.dragAnchorFraction,
        boardHeight * GameConstants.dragAnchorFraction,
      ),
      feedback: Material(
        color: Colors.transparent,
        child: CustomPaint(
          size: Size(boardWidth, boardHeight),
          painter: PiecePainter(
            piece: piece,
            cellSize: boardCellSize,
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.25, child: child),
      onDragStarted: () => context.read<GameCubit>().startDrag(piece.id),
      onDragEnd: (_) => context.read<GameCubit>().tryDropDraggingPiece(),
      onDraggableCanceled: (_, __) {
        context.read<GameCubit>().cancelDrag();
      },
      child: GestureDetector(
        onDoubleTap: () => context.read<GameCubit>().rotatePiece(piece.id),
        child: child,
      ),
    );
  }
}

class PieceTray extends StatelessWidget {
  const PieceTray({super.key});

  double _cellSizeForPiece({
    required BlockPiece piece,
    required double slotWidth,
    required double slotHeight,
  }) {
    final byWidth = slotWidth / piece.width;
    final byHeight = slotHeight / piece.height;

    return [
      byWidth,
      byHeight,
      GameConstants.trayMaxCellSize,
    ].reduce((a, b) => a < b ? a : b).clamp(
          GameConstants.trayMinCellSize,
          GameConstants.trayMaxCellSize,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        const outerPadding = 32.0;
        final innerWidth = screenWidth - outerPadding;
        final boardCellSize = boardCellSizeForWidth(innerWidth);
        final slotWidth = (innerWidth -
                GameConstants.trayHorizontalPadding * 2) /
            GameConstants.trayPieceCount;
        final slotHeight =
            GameConstants.trayHeight - GameConstants.trayVerticalPadding * 2;

        return SizedBox(
          height: GameConstants.trayHeight,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: GameConstants.trayHorizontalPadding,
              vertical: GameConstants.trayVerticalPadding,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: state.trayPieces.map<Widget>((BlockPiece piece) {
                final trayCellSize = _cellSizeForPiece(
                  piece: piece,
                  slotWidth: slotWidth,
                  slotHeight: slotHeight,
                );

                return Expanded(
                  child: Center(
                    child: DraggablePiece(
                      piece: piece,
                      trayCellSize: trayCellSize,
                      boardCellSize: boardCellSize,
                      enabled: state.status == GameStatus.playing,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});

  static const _cellSize = 11.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.next,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 6.0;
                final count = state.previewPieces.length;
                final slotSize = count == 0
                    ? 0.0
                    : (constraints.maxWidth - spacing * (count - 1)) / count;

                return Row(
                  children: state.previewPieces.map<Widget>((BlockPiece piece) {
                    return Container(
                      width: slotSize,
                      height: slotSize,
                      margin: EdgeInsets.only(
                        right: piece == state.previewPieces.last ? 0 : spacing,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest
                            .withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomPaint(
                        size: Size(
                          piece.width * _cellSize,
                          piece.height * _cellSize,
                        ),
                        painter: PiecePainter(
                          piece: piece,
                          cellSize: _cellSize,
                          opacity: 0.85,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
