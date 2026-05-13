import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_config.dart';

/// Initialises the AdMob SDK and exposes helper methods to load
/// Banner, Interstitial, Rewarded and App-Open ads.
class AdsService {
  AdsService._();

  // ── Initialisation ────────────────────────────────────────────────────────

  /// Call once inside main() before runApp().
  static Future<InitializationStatus> initialize() async {
    final status = await MobileAds.instance.initialize();
    if (kDebugMode) {
      debugPrint('[AdsService] Initialized: ${status.adapterStatuses}');
    }
    return status;
  }

  // ── Banner ────────────────────────────────────────────────────────────────

  /// Creates and loads a [BannerAd].
  /// Dispose the returned ad when the widget is removed from the tree.
  static BannerAd createBanner({
    AdSize size = AdSize.banner,
    BannerAdListener? listener,
  }) {
    return BannerAd(
      adUnitId: AdsConfig.bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener:
          listener ??
          BannerAdListener(
            onAdLoaded: (ad) =>
                debugPrint('[AdsService] Banner loaded: ${ad.adUnitId}'),
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
              debugPrint('[AdsService] Banner failed: $error');
            },
          ),
    )..load();
  }

  // ── Interstitial ──────────────────────────────────────────────────────────

  /// Loads an interstitial ad and calls [onLoaded] when ready.
  static Future<void> loadInterstitial({
    required void Function(InterstitialAd ad) onLoaded,
    void Function(LoadAdError error)? onFailed,
  }) async {
    await InterstitialAd.load(
      adUnitId: AdsConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdsService] Interstitial loaded');
          onLoaded(ad);
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdsService] Interstitial failed: $error');
          onFailed?.call(error);
        },
      ),
    );
  }

  /// Convenience: load then immediately show.
  static Future<void> showInterstitial({
    FullScreenContentCallback<InterstitialAd>? fullScreenContentCallback,
    void Function(LoadAdError)? onFailed,
  }) async {
    await loadInterstitial(
      onLoaded: (ad) {
        ad.fullScreenContentCallback =
            fullScreenContentCallback ??
            FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) => ad.dispose(),
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                debugPrint('[AdsService] Interstitial show failed: $error');
              },
            );
        ad.show();
      },
      onFailed: onFailed,
    );
  }

  // ── Rewarded ──────────────────────────────────────────────────────────────

  /// Loads a rewarded ad and calls [onLoaded] when ready.
  static Future<void> loadRewarded({
    required void Function(RewardedAd ad) onLoaded,
    void Function(LoadAdError error)? onFailed,
  }) async {
    await RewardedAd.load(
      adUnitId: AdsConfig.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdsService] Rewarded loaded');
          onLoaded(ad);
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdsService] Rewarded failed: $error');
          onFailed?.call(error);
        },
      ),
    );
  }

  /// Convenience: load then immediately show.
  /// [onEarned] is called with the [RewardItem] when the user earns a reward.
  static Future<void> showRewarded({
    required void Function(AdWithoutView ad, RewardItem reward) onEarned,
    FullScreenContentCallback<RewardedAd>? fullScreenContentCallback,
    void Function(LoadAdError)? onFailed,
  }) async {
    await loadRewarded(
      onLoaded: (ad) {
        ad.fullScreenContentCallback =
            fullScreenContentCallback ??
            FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) => ad.dispose(),
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                debugPrint('[AdsService] Rewarded show failed: $error');
              },
            );
        ad.show(onUserEarnedReward: onEarned);
      },
      onFailed: onFailed,
    );
  }

  // ── App Open ──────────────────────────────────────────────────────────────

  static AppOpenAd? _appOpenAd;

  static Future<void> loadAppOpenAd({
    void Function(LoadAdError)? onFailed,
  }) async {
    await AppOpenAd.load(
      adUnitId: AdsConfig.appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AdsService] App Open loaded');
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AdsService] App Open failed: $error');
          _appOpenAd = null;
          onFailed?.call(error);
        },
      ),
    );
  }

  static void showAppOpenAd({
    FullScreenContentCallback<AppOpenAd>? fullScreenContentCallback,
  }) {
    if (_appOpenAd == null) {
      debugPrint('[AdsService] App Open ad not ready');
      return;
    }
    _appOpenAd!.fullScreenContentCallback =
        fullScreenContentCallback ??
        FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _appOpenAd = null;
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            _appOpenAd = null;
            debugPrint('[AdsService] App Open show failed: $error');
          },
        );
    _appOpenAd!.show();
  }
}
