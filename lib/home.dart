import 'package:admob_rewarded_ad/ad_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdManager adManager = AdManager();

  @override
  void initState() {
    adManager.loadRewardedAd();
    super.initState();
  }

  @override
  void dispose() {
    adManager.disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("RewardedAd"),
          onPressed: () {
            adManager.showRewardedAd();
          },
        ),
      ),
    );
  }
}
