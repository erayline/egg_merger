import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:egg_merge/funcsFolder/reklam.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class upperBar extends StatefulWidget {
  const upperBar({super.key});

  @override
  State<upperBar> createState() => _upperBarState();
}

class _upperBarState extends State<upperBar> {
  late RewardedAd rewardedAd;
  final String rewardedAdUnitId = "ca-app-pub-3869875736697730/4517066483";
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdFailedToLoad: (LoadAdError error) {
          print("couldn't load: ${error}");
        }, onAdLoaded: (RewardedAd ad) {
          print('ad loaded');
          rewardedAd = ad;
          _setFullScreenContentCallback();
        }));
  }

  void _setFullScreenContentCallback() {
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print("$ad onAdShowedFullscreencontent"),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print("$ad onAdDismissedFullSCreenContent");
        // ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print("$ad onadfailedToshowFullScreenContent: $error");
        // ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print("$ad impression occured"),
    );
  }



  void _showRewardedAd(Reklam reklam) {
    rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      reklam.rewardedMoneyBoostStart();
      print("KAZANDIN");
    });
  }

  bool rewardedAdOpen = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Container(
        color: Color.fromARGB(255, 241, 143, 86),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(width: 0,height: 0,),
              upperMoneyBar(),
              upperWingBar(),
              rewardedAdOpen
                  ? GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                decoration: BoxDecoration(color: Color.fromARGB(255, 248, 217, 155),borderRadius: BorderRadius.circular(10)),
                                width: 50,
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('100x MONEY FOR 60s',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () {//ONAYLANDI
                                                Navigator.pop(context);
                                              _showRewardedAd(value.reklam);
                                              Future.delayed(
                                                  Duration(seconds: 3), () {
                                                _loadRewardedAd();
                                                print('yenisi yüklendi');
                                                Future.delayed(Duration(seconds: 140),(){
                                                rewardedAdOpen = true;
                                                });
                                                rewardedAdOpen = false;
                                                
                                              });
                                            },
                                            child: Container(width: 100,height: 50,color: Color.fromARGB(190, 52, 255, 1),child: Center(child: Text('Watch an ad',style: TextStyle(color:Colors.black),)))),
                                        GestureDetector(
                                            onTap: () {//REDDEDİLDİ
                                              rewardedAdOpen = false;
                                              Navigator.pop(context);
                                              Future.delayed(Duration(seconds: 300),(){
                                                rewardedAdOpen = true;
                                              });
                                            },
                                            child: Container(width: 100,height: 50,color: const Color.fromARGB(92, 244, 67, 54),child: Center(child: Text('no thanks'))))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        color: Color.fromARGB(31, 0, 0, 0),
                        width: 60,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.monetization_on),
                          ],
                        ),
                      ),
                    )
                  : (value.reklam.rewardedMoneyBoostActive == 0 ? SizedBox(
                      width: 0,
                      height: 0,
                    ): Container(
                      width: 60,
                      height: 50,
                      color: Color.fromARGB(31, 0, 0, 0),
                      child: Center(child: Text('${value.reklam.rewardedMoneyBoostTimer}',style: TextStyle(color: Colors.amber,fontSize: 19,fontWeight: FontWeight.bold),)))),
            ],
          ),
        ),
      );
    });
  }
}

class upperMoneyBar extends StatefulWidget {
  const upperMoneyBar({super.key});

  @override
  State<upperMoneyBar> createState() => upperMoneyBarState();
}

class upperMoneyBarState extends State<upperMoneyBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 20, 174, 92),borderRadius: BorderRadius.circular(9)),
        height: 40,
        width: MediaQuery.of(context).size.width * 4 / 12,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 6,
            ),
            Image.asset(
              'ourAssets/images/money.png',
              width: 20,
            ),
            Consumer<EggObjectModel>(
              builder: (context, value, child) {
                return Expanded(
                    child: Column(
                  children: [
                    Center(
                        child: Text(bigIntToString(
                            value.ingame_stats_object.totalMoney))),
                    Center(
                      child: Text(
                          bigIntToString(calculateMoneyPerSec(
                                  value.EggIndexList,
                                  value.ingame_stats_object,
                                  value.god_stats_object,
                                  value.reklam)) +
                              "/s",
                          style: TextStyle(
                            color: (value.god_stats_object.priapus_active
                                ? Colors.amber
                                : Colors.black),
                          )),
                    )
                  ],
                ));
              },
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class upperWingBar extends StatefulWidget {
  const upperWingBar({super.key});

  @override
  State<upperWingBar> createState() => _upperWingBarState();
}

class _upperWingBarState extends State<upperWingBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromARGB(255, 20, 174, 92),borderRadius: BorderRadius.circular(9)),
            height: 40,
            width: MediaQuery.of(context).size.width * 4 / 12,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 6,
                ),
                Image.asset(
                  'ourAssets/images/chicken-wings.png',
                  width: 30,
                ),
                Expanded(
                    child: Center(
                        child:
                            Text("${value.ingame_stats_object.goldenWing}"))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class adBox extends StatefulWidget {
  const adBox({super.key});

  @override
  State<adBox> createState() => _adBoxState();
}

class _adBoxState extends State<adBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(
      builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              height: 40,
              width: 40,
              color: Color.fromARGB(255, 20, 174, 92),
              child: Center(
                child: Text(
                    value.ingame_stats_object.merge_level_current.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0,
                      color: Colors.amber,
                    )),
              ),
            ));
      },
    );
  }
}
