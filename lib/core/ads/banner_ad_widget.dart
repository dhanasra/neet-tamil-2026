import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_service.dart';

/// A ready-to-use banner ad widget.
///
/// Usage:
/// ```dart
/// const BannerAdWidget()
/// // or with a custom size:
/// BannerAdWidget(size: AdSize.mediumRectangle)
/// ```
class BannerAdWidget extends StatefulWidget {
  final AdSize size;

  const BannerAdWidget({super.key, this.size = AdSize.banner});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
    final ad = AdsService.createBanner(
      size: widget.size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) setState(() => _isLoaded = false);
          debugPrint('[BannerAdWidget] Failed to load: $error');
        },
        onAdOpened: (_) => debugPrint('[BannerAdWidget] Ad opened'),
        onAdClosed: (_) => debugPrint('[BannerAdWidget] Ad closed'),
      ),
    );
    setState(() => _bannerAd = ad);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return SizedBox(
        height: widget.size.height.toDouble(),
        width: widget.size.width.toDouble(),
      );
    }

    return SizedBox(
      height: _bannerAd!.size.height.toDouble(),
      width: double.infinity,
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
