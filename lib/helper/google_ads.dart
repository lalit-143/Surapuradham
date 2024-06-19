import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:surapuradham/helper/ad_helper.dart';

// Banner Ads
class ShowBannerAd extends StatefulWidget {
  const ShowBannerAd({super.key});

  @override
  State<ShowBannerAd> createState() => _ShowBannerAdState();
}

class _ShowBannerAdState extends State<ShowBannerAd> {
  BannerAd? _bannerAd;
  @override
  void initState() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null) {
      return Container(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return Container();
    }
  }
}

// Interstitial Ads
class ShowInterstitialAd {
  InterstitialAd? _interstitialAd;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print("-------------Ad End-------------");
            },
          );
          _interstitialAd = ad;
          if (_interstitialAd != null) {
            _interstitialAd?.show();
          }
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
}

// Rewarded Ads
class ShowRewardedAd {
  RewardedAd? _rewardedAd;

  void loadAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
            },
          );
          _rewardedAd = ad;

          if (_rewardedAd != null) {
            _rewardedAd?.show(
              onUserEarnedReward: (_, reward) {
                print("Rewarded");
              },
            );
          }
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }
}
