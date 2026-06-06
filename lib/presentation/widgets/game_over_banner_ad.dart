import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/constants/ad_constants.dart';

class GameOverBannerAd extends StatefulWidget {
  const GameOverBannerAd({super.key});

  static bool get isSupported {
    if (kIsWeb) return false;

    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  State<GameOverBannerAd> createState() => _GameOverBannerAdState();
}

class _GameOverBannerAdState extends State<GameOverBannerAd> {
  BannerAd? _bannerAd;
  var _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    if (!GameOverBannerAd.isSupported) return;

    final banner = BannerAd(
      adUnitId: AdConstants.gameOverBannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Game over banner ad failed to load: $error');
        },
      ),
    );

    _bannerAd = banner;
    await banner.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!GameOverBannerAd.isSupported || !_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final width = _bannerAd!.size.width.toDouble();
    final height = _bannerAd!.size.height.toDouble();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
