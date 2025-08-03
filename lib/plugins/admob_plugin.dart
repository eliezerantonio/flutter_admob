import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final adBannerId = Platform.isAndroid
    ? "ca-app-pub-3940256099942544/9214589741"
    : "ca-app-pub-3940256099942544/2435281174";

final adInterstialId = Platform.isAndroid
    ? "ca-app-pub-3940256099942544/1033173712"
    : "ca-app-pub-3940256099942544/4411468910";

final adRewardId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/5224354917'
    : 'ca-app-pub-3940256099942544/1712485313';

class AdmobPlugin {
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  static Future<BannerAd> loadBannerAd() async {
    return BannerAd(
      adUnitId: adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // Called when an ad is successfully received.
          debugPrint("Ad was loaded.");
        },
        onAdFailedToLoad: (ad, err) {
          // Called when an ad request failed.
          debugPrint("Ad failed to load with error: $err");
          ad.dispose();
        },
      ),
    )..load();
  }

  static Future<InterstitialAd> loadInterstialAd() async {
    Completer<InterstitialAd> completer = Completer();

    InterstitialAd.load(
      adUnitId: adInterstialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _setFullScreenContentCallback(ad);
          // Called when an ad is successfully received.
          debugPrint('Ad was loaded.');
          // Keep a reference to the ad so you can show it later.
          completer.complete(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Called when an ad request failed.
          completer.completeError(error);
          debugPrint('Ad failed to load with error: $error');
        },
      ),
    );

    return completer.future;
  }

  static Future<RewardedAd> loadRewardedAd() async {
    Completer<RewardedAd> completer = Completer();
    RewardedAd.load(
      adUnitId: adRewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          log('$ad loaded.');

          completer.complete(ad);
          // Keep a reference to the ad so you can show it later.
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error');
          completer.completeError(error);
        },
      ),
    );

    return completer.future;
  }

  static void _setFullScreenContentCallback(InterstitialAd ad) {
    // [START ad_events]
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        // Called when the ad showed the full screen content.
        debugPrint('Ad showed full screen content.');
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        // Called when the ad failed to show full screen content.
        debugPrint('Ad failed to show full screen content with error: $err');
        // Dispose the ad here to free resources.
        ad.dispose();
      },
      onAdDismissedFullScreenContent: (ad) {
        // Called when the ad dismissed full screen content.
        debugPrint('Ad was dismissed.');
        // Dispose the ad here to free resources.
        ad.dispose();
      },
      onAdImpression: (ad) {
        // Called when an impression occurs on the ad.
        debugPrint('Ad recorded an impression.');
      },
      onAdClicked: (ad) {
        // Called when a click is recorded for an ad.
        debugPrint('Ad was clicked.');
      },
    );
  }
}
