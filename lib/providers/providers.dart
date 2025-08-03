import 'package:flutter_admob_/plugins/admob_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final bannerAdProvider = FutureProvider<BannerAd>((ref) async {
  final ad = await AdmobPlugin.loadBannerAd();
  return ad;
});

final bannerIntertialProvider = FutureProvider<InterstitialAd>((ref) async {
  final ad = await AdmobPlugin.loadInterstialAd();

  return ad;
});
