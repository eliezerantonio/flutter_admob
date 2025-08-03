import 'package:flutter_admob_/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admob_/screens/ads/full_screen.dart';
import 'package:flutter_admob_/screens/ads/reward_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAdProviderAsync = ref.watch(bannerAdProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FullScreen()),
                );
              },
              child: Text("FullScreen"),
            ),

            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RewardScreen()),
                );
              },
              child: Text("Rewards ads"),
            ),

            bannerAdProviderAsync.when(
              data: (banner) => SizedBox(
                width: banner.size.width.toDouble(),
                height: banner.size.height.toDouble(),
                child: AdWidget(ad: banner),
              ),
              error: (error, stackTrace) => Text("error $error"),
              loading: () => CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
