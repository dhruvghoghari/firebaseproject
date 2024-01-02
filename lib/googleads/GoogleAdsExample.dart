import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../resources/AdResources.dart';

class GoogleAdsExample extends StatefulWidget {
  @override
  State<GoogleAdsExample> createState() => _GoogleAdsExampleState();
}
//ca-app-pub-1431816577529734~4254838186
//ca-app-pub-1431816577529734/3989553805

class _GoogleAdsExampleState extends State<GoogleAdsExample> {

  BannerAd? _topBannerAd;
  bool _isTop = false;

  BannerAd? _bottomBannerAd;
  bool _isBottom = false;


  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;


  TopBanner() {
    _topBannerAd = BannerAd(
      adUnitId: AdResources.TOP_BANNER,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isTop = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _topBannerAd!.load();
  }

  BottomBanner() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdResources.BOTTOM_BANNER,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottom = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd!.load();
  }

  loadinterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdResources.iNTERSTITAL_BANNER,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _interstitialAd = null;
          },
        ));
  }
  showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadinterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadinterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  createRewardedAd() async{
    RewardedAd.load(
      adUnitId: AdResources.REVERD_BANNER,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;

          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            createRewardedAd();
          }),);
  }
  showRewardedAd()async {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        });
    // _rewardedAd!.show(onUserEarnedReward: );
    _rewardedAd = null;
  }


  @override
  void initState() {
    super.initState();
    TopBanner();
    BottomBanner();
    loadinterstitialAd();
    createRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        child: Icon(Icons.exit_to_app),
        backgroundColor: Color(0xFFE57373),
        onPressed: () {
          var snackbar = SnackBar(
            content: Text("Press Again To Exit"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        },
      ),

      appBar: AppBar(
        title: Text("Google Ads"),
      ),
      body: Column(
        children: [
          _isTop ? Container(
            height: _topBannerAd!.size.height.toDouble(),
            width: _topBannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _topBannerAd!),
          ): SizedBox(height: 0),

          _isBottom ? Container(
            height: _bottomBannerAd!.size.height.toDouble(),
            width: _bottomBannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerAd!),
          ): SizedBox(height: 0),

          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             ElevatedButton(onPressed: (){
               showInterstitialAd();
             }, child: Text("Interstitial")),

              ElevatedButton(onPressed: (){
                showRewardedAd();
              }, child: Text("Rewarded"))
            ],
          ),
        ],
      ),
    );
  }
}
