
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdmobHelper {

  static String get bannerUnit => 'ca-app-pub-3940256099942544/6300978111';

  InterstitialAd? _interstitialAd;

  int num_of_attempt_load = 0;

  static initialization(){
    if(MobileAds.instance == null)
      {
        MobileAds.instance.initialize();
      }
  }
  static BannerAd getBannerAd(){
    BannerAd bAd = new BannerAd(size: AdSize.fullBanner, adUnitId: 'ca-app-pub-3940256099942544/6300978111' , listener: BannerAdListener(
        onAdClosed: (Ad ad){
          print("Ad Closed");
        },
        onAdFailedToLoad: (Ad ad,LoadAdError error){
          ad.dispose();
        },
        onAdLoaded: (Ad ad){
          print('Ad Loaded');
        },
        onAdOpened: (Ad ad){
          print('Ad opened');
        }
    ), request: AdRequest());

    return bAd;
  }


  void createInterad(){

    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback:InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad){
              _interstitialAd = ad;
              num_of_attempt_load =0;
            },
            onAdFailedToLoad: (LoadAdError error){
              num_of_attempt_load +1;
              _interstitialAd = null;

              if(num_of_attempt_load<=2){
                createInterad();
              }
            }),
    );

  }

  void showInterad(){
     if(_interstitialAd == null){
       return;
     }

     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(

       onAdShowedFullScreenContent: (InterstitialAd ad){
         print("ad onAdshowedFullscreen");
       },
       onAdDismissedFullScreenContent: (InterstitialAd ad){
         print("ad Disposed");
         ad.dispose();
       },
       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror){
         print('$ad OnAdFailed $aderror');
         ad.dispose();
         createInterad();
       }


     );

     _interstitialAd!.show();

     _interstitialAd = null;
  }


}