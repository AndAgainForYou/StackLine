import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import '../../l10n/app_localizations.dart';

class ScoreHeader extends StatelessWidget {
  const ScoreHeader({super.key});

  static const double _tileHeight = 82;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        return LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 12.0;
            final tileWidth = (constraints.maxWidth - spacing * 2) / 3;

            return Row(
              children: [
                SizedBox(
                  width: tileWidth,
                  height: _tileHeight,
                  child: _MetricTile(
                    label: l10n.scoreLabel,
                    value: state.score.toString(),
                    highlight: state.lastScoreGain,
                    highlightText: state.lastScoreGain != null &&
                            state.lastScoreGain! > 0
                        ? l10n.scoreGain(state.lastScoreGain!)
                        : null,
                  ),
                ),
                const SizedBox(width: spacing),
                SizedBox(
                  width: tileWidth,
                  height: _tileHeight,
                  child: _MetricTile(
                    label: l10n.best,
                    value: state.highScore.toString(),
                  ),
                ),
                const SizedBox(width: spacing),
                SizedBox(
                  width: tileWidth,
                  height: _tileHeight,
                  child: _MetricTile(
                    label: l10n.combo,
                    value: '${state.comboMultiplier.toStringAsFixed(1)}x',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    this.highlight,
    this.highlightText,
  });

  final String label;
  final String value;
  final int? highlight;
  final String? highlightText;

  @override
  Widget build(BuildContext context) {
    final showHighlight = highlightText != null && highlightText!.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: showHighlight
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: showHighlight ? 1 : 0,
                child: Text(
                  showHighlight ? highlightText! : '',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
