import 'dart:io';

/// Central configuration for all AdMob ad unit IDs.
///
/// ⚠️  Replace the test IDs below with your real IDs before publishing.
/// Real IDs are available in your AdMob dashboard → Apps → Ad units.
class AdsConfig {
  AdsConfig._();

  // ── Android ---------------------------------------------------------------
  static const String _androidBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const String _androidInterstitial =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _androidRewarded =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _androidRewardedInter =
      'ca-app-pub-3940256099942544/5354046379';
  static const String _androidAppOpen =
      'ca-app-pub-3940256099942544/9257395921';
  static const String _androidNative = 'ca-app-pub-3940256099942544/2247696110';

  // ── iOS ------------------------------------------------------------------
  static const String _iosBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const String _iosInterstitial =
      'ca-app-pub-3940256099942544/4411468910';
  static const String _iosRewarded = 'ca-app-pub-3940256099942544/1712485313';
  static const String _iosRewardedInter =
      'ca-app-pub-3940256099942544/6978759866';
  static const String _iosAppOpen = 'ca-app-pub-3940256099942544/5575463023';
  static const String _iosNative = 'ca-app-pub-3940256099942544/3986624511';

  // ── Platform helpers -----------------------------------------------------
  static bool get _isAndroid => Platform.isAndroid;

  static String get bannerAdUnitId => _isAndroid ? _androidBanner : _iosBanner;

  static String get interstitialAdUnitId =>
      _isAndroid ? _androidInterstitial : _iosInterstitial;

  static String get rewardedAdUnitId =>
      _isAndroid ? _androidRewarded : _iosRewarded;

  static String get rewardedInterstitialAdUnitId =>
      _isAndroid ? _androidRewardedInter : _iosRewardedInter;

  static String get appOpenAdUnitId =>
      _isAndroid ? _androidAppOpen : _iosAppOpen;

  static String get nativeAdUnitId => _isAndroid ? _androidNative : _iosNative;
}
