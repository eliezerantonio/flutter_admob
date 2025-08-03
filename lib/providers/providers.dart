import 'package:flutter_admob_/plugins/admob_plugin.dart';
import 'package:flutter_admob_/providers/show_ads_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final bannerAdProvider = FutureProvider<BannerAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);

  if (!showAds) throw "ads Blocked";
  final ad = await AdmobPlugin.loadBannerAd();
  return ad;
});

final bannerIntertialProvider = FutureProvider.autoDispose<InterstitialAd>((
  ref,
) async {
  final showAds = ref.watch(showAdsProvider);

  if (!showAds) throw "ads Blocked";
  final ad = await AdmobPlugin.loadInterstialAd();
 
  return ad;
});

final rewardedAdProvider = FutureProvider.autoDispose<RewardedAd>((ref) async {
  final showAds = ref.watch(showAdsProvider);

  if (!showAds) throw "ads Blocked";
  final ad = await AdmobPlugin.loadRewardedAd();
  return ad;
});

final adPointsProvider = StateProvider((ref) {
  return 0;
});
