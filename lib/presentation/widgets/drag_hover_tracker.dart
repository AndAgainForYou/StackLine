import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/block_piece.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';

/// Tracks pointer position during drag so board preview aligns with the piece.
class DragHoverTracker extends StatelessWidget {
  const DragHoverTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (prev, next) => prev.isDragging != next.isDragging,
      builder: (context, state) {
        if (!state.isDragging) return const SizedBox.shrink();

        return Positioned.fill(
          child: DragTarget<BlockPiece>(
            onWillAcceptWithDetails: (_) => true,
            onMove: (details) {
              context.read<GameCubit>().updateHoverFromPointer(details.offset);
            },
            onLeave: (_) => context.read<GameCubit>().clearHoverPreview(),
            builder: (context, _, __) => const SizedBox.expand(),
          ),
        );
      },
    );
  }
}
