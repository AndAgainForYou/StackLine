import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage_service.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../l10n/app_localizations.dart';
import '../../presentation/services/sound_service.dart';
import '../../presentation/widgets/locale_picker_button.dart';
import '../../presentation/widgets/theme_picker_button.dart';
import 'about_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.storage});

  final LocalStorageService storage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _highScore;
  late bool _hasSavedGame;

  @override
  void initState() {
    super.initState();
    _refreshStats();
  }

  void _refreshStats() {
    _highScore = widget.storage.getHighScore();
    _hasSavedGame = widget.storage.hasSavedGame();
  }

  Future<void> _openGame({required bool continueSaved}) async {
    final sound = SoundService();
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) {
            final cubit = GameCubit(
              storage: widget.storage,
              soundService: sound,
            );
            if (continueSaved) {
              cubit.continueSavedGame();
            } else {
              cubit.startGame();
            }
            return cubit;
          },
          child: GameScreen(soundService: sound),
        ),
      ),
    );

    if (!mounted) return;
    setState(_refreshStats);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AboutScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info_outline_rounded, size: 20),
                    label: Text(l10n.howToPlay),
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LocalePickerButton(),
                      ThemePickerButton(),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                l10n.appTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.homeTagline,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 32),
              _StatCard(
                label: l10n.highScore,
                value: _highScore.toString(),
              ),
              const Spacer(flex: 2),
              if (_hasSavedGame) ...[
                FilledButton(
                  onPressed: () => _openGame(continueSaved: true),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(l10n.continueGame),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => _openGame(continueSaved: false),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(l10n.newGame),
                ),
              ] else
                FilledButton(
                  onPressed: () => _openGame(continueSaved: false),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(l10n.play),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
