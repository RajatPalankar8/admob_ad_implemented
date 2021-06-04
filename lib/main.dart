import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_simple/AdmobHelper.dart';
import 'package:flutter_app_simple/RewardedAdsExample.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdmobHelper.initialization();
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admob ad example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(create:(BuildContext context)=> AdmobHelper(),child: RewardedAdsPage()),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
 List<String> datas;   // late for null safty
   List<Object> dataads;  // will store both data + banner ads

AdmobHelper admobHelper = new AdmobHelper();   // object to access methods of AdmobHelper class
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    datas = [];

    //generate array list of string
    for(int i = 1; i <= 20; i++){
      datas.add("List Item $i");
    }

    dataads = List.from(datas);

    // insert admob banner object in between the array list
    for(int i =0 ; i<=2; i ++){
      var min = 1;
      var rm = new Random();

      //generate a random number from 2 to 18 (+ 1)
      var rannumpos = min + rm.nextInt(18);

      //and add the banner ad to particular index of arraylist
      dataads.insert(rannumpos, AdmobHelper.getBannerAd()..load());

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: dataads.length,
          itemBuilder: (context,index){
            //id dataads[index] is string show listtile with item in it
            if(dataads[index] is String)
              {
                return ListTile(
                  title: Text(dataads[index].toString()),
                  leading: Icon(Icons.exit_to_app),
                  trailing: Icon(Icons.ice_skating),
                  onTap: (){
                    admobHelper.createInterad();   // call create Interstitial ads
                  },
                  onLongPress: (){
                    admobHelper.showInterad();     // call  show Interstitial ads
                  },

                );
              }else{
              // if dataads[index] is object (ads) then show container with adWidget
              final Container adcontent = Container(
                child: AdWidget(
                  ad: dataads[index] as BannerAd,
                  key: UniqueKey(),
                ),
                height: 50,
              );
              return adcontent;
            }

      }),
      bottomNavigationBar: Container(
        child: AdWidget(
          ad:AdmobHelper.getBannerAd()..load(),
          key: UniqueKey(),
        ),
        height: 50,
      ),

    );
  }
}





