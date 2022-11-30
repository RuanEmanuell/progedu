import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_mob_service.dart';

class Controller extends ChangeNotifier {
  String language = "english";

  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  bool reward = false;

  //Text input color variable
  Color inputColor = const Color.fromARGB(255, 253, 228, 0);

  //Loading and navigation variables
  bool loading = false;
  int selectedPageIndex = 0;

  //Games variables
  int questionCount = 0;
  int correctCount = 0;
  bool correctTextController = false;
  bool correct = false;
  bool tappable = true;
  dynamic controller;
  Color correctColorController = Colors.red;

  //Change input color
  void inputTap() {
    inputColor = const Color.fromARGB(255, 253, 228, 0);
    notifyListeners();
  }

  void inputActive() {
    inputColor = const Color.fromARGB(255, 0, 255, 8);
    notifyListeners();
  }

  //Loading functions
  void startLoading() {
    loading = true;
    notifyListeners();
  }

  void stopLoading() {
    loading = false;
    notifyListeners();
  }

  //Bottom Navigation bar controller
  void changeBottomNavigation() {
    selectedPageIndex = selectedPageIndex;
    notifyListeners();
  }

  //Quiz questions controllers
  void passQuestion() {
    Future.delayed(const Duration(seconds: 3), () {
      correct = false;
      questionCount++;
      correctColorController = Colors.red;
      correctTextController = false;
      isTappable();
      notifyListeners();
    });
  }

  void isTappable() {
    tappable = true;
    notifyListeners();
  }

  void showCorrect() {
    correct = true;
    tappable = false;
    notifyListeners();
  }

  void correctQuestion() {
    correctCount++;
    correctTextController = true;
    correctColorController = Colors.green;
    notifyListeners();
  }

  void resetAnwser() {
    Future.delayed(const Duration(seconds: 3), () {
      controller.text = "";
      notifyListeners();
    });
  }

  void resetQuestions() {
    questionCount = 0;
    correctCount = 0;
    notifyListeners();
  }

  void createInterAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialadUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: ((ad) {
            interstitialAd = ad;
          }),
          onAdFailedToLoad: (error) {
            interstitialAd = null;
          },
        ));
  }

  void createRewardAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardedadUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: ((ad) {
            rewardedAd = ad;
          }),
          onAdFailedToLoad: (error) {
            rewardedAd = null;
          },
        ));
  }

  void showInterAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterAd();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

  void showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterAd();
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (ad, rewardSet) {},
      );
      rewardedAd = null;
    }
    reward = true;
    notifyListeners();
  }

  void resetReward() {
    reward = false;
    notifyListeners();
  }
}
