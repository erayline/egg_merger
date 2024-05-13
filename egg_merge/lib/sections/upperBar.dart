import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/numberFormating.dart';
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
    if (rewardedAd == null) return;

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

  void _showRewardedAd() {
    rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      num amount = rewardItem.amount;
      print("KAZANDIN");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 223, 151, 109),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[upperMoneyBar(),
        upperWingBar(),
        InkWell(
                onTap: (){
                  _showRewardedAd();
                  Future.delayed(Duration(seconds: 3),(){
                  _loadRewardedAd();
                  print('yenisi yüklendi');
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.monetization_on),
                ),
              ),],
      ),
    );
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
        height: 40,
        width: MediaQuery.of(context).size.width * 4 / 12,
        color: Color.fromARGB(255, 20, 174, 92),
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
                                  value.god_stats_object)) +
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
            height: 40,
            width: MediaQuery.of(context).size.width * 4 / 12,
            color: Color.fromARGB(255, 20, 174, 92),
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
