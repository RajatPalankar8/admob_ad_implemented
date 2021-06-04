import 'package:flutter/material.dart';
import 'package:flutter_app_simple/AdmobHelper.dart';
import 'package:provider/provider.dart';

class RewardedAdsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    AdmobHelper admobHelper = Provider.of<AdmobHelper>(context,listen: false);

    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AdmobHelper>(builder: (context,date,child){
              return Text("Rewarded Point is ${admobHelper.getrewardpoint()}");
            },),
            ElevatedButton(onPressed: (){admobHelper.loadRewardedAd();}, child: Text("Load Rewarded Ads")),
            ElevatedButton(onPressed: (){admobHelper.showRewaredAd();}, child: Text("Show Rewarded Ads")),
          ],
        ),
      ),
    );
  }
}
