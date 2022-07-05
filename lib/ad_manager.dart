import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  RewardedAd? rewardedAd;

  String adUnitId = () {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else {
      return "ca-app-pub-3940256099942544/1712485313";
    }
  }();

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print("Ad Loaded");
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          rewardedAd = null;
          print('error : $error');
        },
      ),
    );
  }

  void showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          // Do something after ad shows
        },
        onAdDismissedFullScreenContent: (ad) {
          // Do something after ad dismissed
          ad.dispose();
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          /// Do something if ad failed to show
          ad.dispose();
        },
      );
      rewardedAd!.setImmersiveMode(true); // hide status bar and nav button
      rewardedAd!.show(
        onUserEarnedReward: ((ad, reward) {
          print('${reward.amount} ${reward.type}');
        }),
      );
    }
  }

  void disposeAd() {
    rewardedAd?.dispose();
  }
}
