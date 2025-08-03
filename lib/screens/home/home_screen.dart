import 'package:flutter/material.dart';
import 'package:flutter_admob_/screens/ads/full_screen.dart';
import 'package:flutter_admob_/screens/ads/reward_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
