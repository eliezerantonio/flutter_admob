import 'package:flutter_admob_/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RewardScreen extends ConsumerWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adRewardedAsyncProvider = ref.watch(rewardedAdProvider);
    final points = ref.watch(adPointsProvider);
    ref.listen(rewardedAdProvider, (pre, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;

      next.value!.show(
        onUserEarnedReward: (ad, reward) {
          ref.read(adPointsProvider.notifier).update((state) => state += 40);
        },
      );
    });

    if (adRewardedAsyncProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text("Carregando add...")),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Total de pontos $points")),
    );
  }
}
