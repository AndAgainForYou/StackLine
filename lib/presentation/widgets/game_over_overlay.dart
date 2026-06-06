import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/constants/ad_constants.dart';
import '../../features/game/bloc/game_cubit.dart';
import '../../features/game/bloc/game_state.dart';
import '../../l10n/app_localizations.dart';
import 'game_over_banner_ad.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key, this.forceShow = false});

  /// Set to true temporarily to preview the overlay in the IDE.
  final bool forceShow;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final visible = forceShow || state.status == GameStatus.gameOver;
        if (!visible) return const SizedBox.shrink();

        final score = forceShow && state.score == 0 ? 3840 : state.score;
        final best = forceShow && state.highScore == 0 ? 5120 : state.highScore;
        final isNewRecord = score >= best && score > 0;

        return SizedBox.expand(
          child: _GameOverPanel(
            score: score,
            best: best,
            isNewRecord: isNewRecord,
            onPlayAgain: () => context.read<GameCubit>().startGame(),
            onContinue: () =>
                context.read<GameCubit>().continueAfterGameOver(),
            onMenu: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Panel
// ---------------------------------------------------------------------------

class _GameOverPanel extends StatefulWidget {
  const _GameOverPanel({
    required this.score,
    required this.best,
    required this.isNewRecord,
    required this.onPlayAgain,
    required this.onContinue,
    required this.onMenu,
  });

  final int score;
  final int best;
  final bool isNewRecord;
  final VoidCallback onPlayAgain;
  final VoidCallback onContinue;
  final VoidCallback onMenu;

  @override
  State<_GameOverPanel> createState() => _GameOverPanelState();
}

class _GameOverPanelState extends State<_GameOverPanel>
    with SingleTickerProviderStateMixin {
  // ── Entrance animation ───────────────────────────────────────────────────
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  // ── Interstitial ad ──────────────────────────────────────────────────────
  InterstitialAd? _interstitialAd;
  bool _adLoading = false;
  bool _adUsed = false; // only allow "Continue" once

  static bool get _adsSupported {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _ctrl.forward();
    _preloadInterstitial();
  }

  void _preloadInterstitial() {
    if (!_adsSupported) return;
    InterstitialAd.load(
      adUnitId: AdConstants.continueInterstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          _interstitialAd = ad;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed to load: $error');
        },
      ),
    );
  }

  Future<void> _onContinueTapped() async {
    if (_adUsed) return;
    _adUsed = true;

    if (!_adsSupported || _interstitialAd == null) {
      // No ad available — continue anyway (good UX, don't punish the user).
      widget.onContinue();
      return;
    }

    setState(() => _adLoading = true);

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        if (mounted) {
          setState(() => _adLoading = false);
          widget.onContinue();
        }
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        debugPrint('Interstitial failed to show: $error');
        if (mounted) {
          setState(() => _adLoading = false);
          widget.onContinue();
        }
      },
    );

    await _interstitialAd!.show();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  // ── Build ────────────────────────────────────────────────────────────────

  static const _btnHeight = 48.0;
  static const _btnPadding = EdgeInsets.symmetric(horizontal: 12);
  static const _btnRadius = 16.0;

  ButtonStyle _filledBtnStyle() => FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, _btnHeight),
        padding: _btnPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_btnRadius),
        ),
      );

  ButtonStyle _outlinedBtnStyle({
    required Color sideColor,
    Color? foregroundColor,
  }) =>
      OutlinedButton.styleFrom(
        minimumSize: const Size(0, _btnHeight),
        padding: _btnPadding,
        foregroundColor: foregroundColor,
        side: BorderSide(color: sideColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_btnRadius),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pull colors from the card surface so everything is guaranteed to
    // contrast correctly regardless of the active theme variant.
    final cs = theme.colorScheme;
    final cardBg = cs.surfaceContainerHigh;
    final onCard = cs.onSurface;
    final dividerColor = cs.outlineVariant;
    final mutedText = onCard.withValues(alpha: 0.55);
    final primaryOnCard = cs.primary;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => FadeTransition(
        opacity: _fade,
        child: child,
      ),
      child: Container(
        color: Colors.black.withValues(alpha: 0.72),
        alignment: Alignment.center,
        child: SlideTransition(
          position: _slide,
          child: ScaleTransition(
            scale: _scale,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Material(
                color: cardBg,
                borderRadius: BorderRadius.circular(24),
                elevation: 8,
                shadowColor: Colors.black.withValues(alpha: 0.4),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Headline chip ──────────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        decoration: BoxDecoration(
                          color: primaryOnCard.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: primaryOnCard.withValues(alpha: 0.30),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          l10n.gameOver.toUpperCase(),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: primaryOnCard,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Score row ──────────────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: dividerColor.withValues(alpha: 0.5)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _ScoreTile(
                                label: l10n.scoreLabel,
                                value: widget.score,
                                valueColor: primaryOnCard,
                                labelColor: mutedText,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 48,
                              color: dividerColor.withValues(alpha: 0.6),
                            ),
                            Expanded(
                              child: _ScoreTile(
                                label: l10n.best,
                                value: widget.best,
                                valueColor: onCard,
                                labelColor: mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── New record badge ───────────────────────────
                      if (widget.isNewRecord) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD600).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: const Color(0xFFFFD600).withValues(alpha: 0.55),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🏆',
                                  style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 6),
                              Text(
                                'New Record!',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: isDark
                                      ? const Color(0xFFFFD600)
                                      : const Color(0xFFB8860B),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // ── Banner ad ──────────────────────────────────
                      const GameOverBannerAd(),

                      const SizedBox(height: 20),

                      // ── Play Again ─────────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        height: _btnHeight,
                        child: FilledButton.icon(
                          onPressed: widget.onPlayAgain,
                          icon: const Icon(Icons.replay_rounded, size: 20),
                          label: Text(
                            l10n.playAgain,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          style: _filledBtnStyle(),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ── Continue + Main Menu (one row) ─────────────
                      Row(
                        children: [
                          if (!_adUsed) ...[
                            Expanded(
                              child: SizedBox(
                                height: _btnHeight,
                                child: OutlinedButton.icon(
                                  onPressed: _adLoading
                                      ? null
                                      : _onContinueTapped,
                                  icon: _adLoading
                                      ? SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: primaryOnCard,
                                          ),
                                        )
                                      : Icon(
                                          Icons.play_circle_outline_rounded,
                                          color: primaryOnCard,
                                          size: 20,
                                        ),
                                  label: Text(
                                    l10n.continueGame,
                                    style: TextStyle(
                                      color: primaryOnCard,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: _outlinedBtnStyle(
                                    sideColor:
                                        primaryOnCard.withValues(alpha: 0.55),
                                    foregroundColor: primaryOnCard,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: SizedBox(
                              height: _btnHeight,
                              child: OutlinedButton(
                                onPressed: widget.onMenu,
                                style: _outlinedBtnStyle(
                                  sideColor:
                                      dividerColor.withValues(alpha: 0.7),
                                ),
                                child: Text(
                                  l10n.gameOverMainMenu,
                                  style: TextStyle(
                                    color: mutedText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Score tile
// ---------------------------------------------------------------------------

class _ScoreTile extends StatelessWidget {
  const _ScoreTile({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.labelColor,
  });

  final String label;
  final int value;
  final Color valueColor;
  final Color labelColor;

  String _format(int n) {
    if (n < 1000) return '$n';
    if (n < 1000000) {
      final k = n / 1000;
      return '${k % 1 == 0 ? k.toInt() : k.toStringAsFixed(1)}k';
    }
    return '${(n / 1000000).toStringAsFixed(1)}M';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: labelColor,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _format(value),
          style: theme.textTheme.headlineMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w800,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
