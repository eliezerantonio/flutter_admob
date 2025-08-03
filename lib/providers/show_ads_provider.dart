import 'package:flutter_admob_/plugins/shared_preferences_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(true) {
    checkAdState();
  }

  void checkAdState() async {
    state = await SharedPreferencesPlugin.get("showAds") ?? true;
  }

  void showAds() {
    SharedPreferencesPlugin.setBool("showAds", true);
    state = true;
  }

  void remove() {
    SharedPreferencesPlugin.setBool("showAds", false);
    state = false;
  }

  void toggleAds() {
    state ? remove() : showAds();
  }
}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});
