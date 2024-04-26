import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmptyEgg extends StatelessWidget {
  const EmptyEgg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      color: Colors.black12,
    );
  }
}

class EggObject {
  int level = 0;
}
//IMAGE STRINGLERI

class EggObjectModel extends ChangeNotifier {
//YUMURTA OBJELERININI BARINDIRIYOR INDEX'E GORE ISLEM YAPIYORUZ
  List<EggObject> EggIndexList = [];

  UpgradeStats upgrade_stats_object = new UpgradeStats();
  InGameStatsObject ingame_stats_object = new InGameStatsObject();

  void increaseBaseEgg(UpgradeStats upgrade_stats_object,
      InGameStatsObject ingame_stats_object) {
    upgrade_stats_object.base_egg_level++;
    ingame_stats_object.totalMoney -=
        upgrade_stats_object.base_egg_level_increase_cost;
    upgrade_stats_object.setNewBaseEggLevel();

    for (int n = 0; n < 20; n++) {
      if (EggIndexList[n].level < upgrade_stats_object.base_egg_level &&
          EggIndexList[n].level != 0) {
        EggIndexList[n].level = upgrade_stats_object.base_egg_level;
      }
    }

    notifyListeners();
  }
  //OYUN ICI DEGISKENLER




  late Map<String, Object> data = {};

  //oyunu kaydetme fonksiyonumuz
  void saveTheGame() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt("base_egg_level", upgrade_stats_object.base_egg_level);
    storage.setString("base_egg_level_increase_cost",upgrade_stats_object.base_egg_level_increase_cost.toString());
    storage.setDouble("spawn_time", upgrade_stats_object.spawn_time);
    storage.setDouble("spawn_time_counter", upgrade_stats_object.spawn_time_counter);
    storage.setInt("spawn_time_decreaser_amount",upgrade_stats_object.spawn_time_decreaser_amount);
    storage.setString("spawn_time_decreaser_cost", upgrade_stats_object.spawn_time_decreaser_cost.toString());
    storage.setInt("current_prestige_amount",ingame_stats_object.currentPrestigePoint);
    storage.setInt("allTimeEggLevel", ingame_stats_object.allTimeEggLevel);
    storage.setInt("willGainAmountPrestigePoint", ingame_stats_object.willGainAmountPrestigePoint);

    storage.setString("totalMoney", ingame_stats_object.totalMoney.toString());
    storage.setString("allTimeMoney", ingame_stats_object.allTimeMoney.toString());

    
    String eggLevelsString="";
    for(int n=0;n<20;n++){
      eggLevelsString+=EggIndexList[n].level.toString() + "."; // from 0 to 19 
    }
    storage.setString("EggIndexListString", eggLevelsString);

  }

  //oyunu yükleme fonksiyonumuz
  void loadTheGame() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    upgrade_stats_object.base_egg_level = storage.getInt("base_egg_level") ?? 1;
    upgrade_stats_object.base_egg_level_increase_cost = BigInt.parse(storage.getString("base_egg_level_increase_cost").toString());
    upgrade_stats_object.spawn_time = storage.getDouble("spawn_time") ?? 40.0;
    upgrade_stats_object.spawn_time_counter = storage.getDouble("spawn_time_counter") ?? 40.0;
    upgrade_stats_object.spawn_time_decreaser_amount = storage.getInt("spawn_time_decreaser_amount") ?? 0;
    upgrade_stats_object.spawn_time_decreaser_cost = BigInt.parse(storage.getString("spawn_time_decreaser_cost").toString());

    ingame_stats_object.currentPrestigePoint= storage.getInt("current_prestige_amount") ?? 0;
    ingame_stats_object.allTimeEggLevel= storage.getInt("allTimeEggLevel") ?? 1;
    ingame_stats_object.willGainAmountPrestigePoint= storage.getInt("willGainAmountPrestigePoint") ?? 0;

    ingame_stats_object.totalMoney = BigInt.parse(storage.getString("totalMoney").toString());
    ingame_stats_object.allTimeMoney = BigInt.parse(storage.getString("allTimeMoney").toString());


    String eggIndexListString0=storage.getString("EggIndexListString")??"0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.";
    List<String> eggIndexListString1=eggIndexListString0.split(".");
    for(int n=0;n<20;n++){
      EggIndexList[n].level = int.parse(eggIndexListString1[n]);
    }


    var dataString = storage.getString("data");
    data = dataString != null
        ? Map<String, Object>.from(jsonDecode(dataString))
        : {};
  }


  //BU IKISI PARA URETIMINDEN SORUMLU
  BigInt produceMoney(int index) {
    BigInt sonuc = BigInt.from(3).pow(EggIndexList[index].level - 1) + BigInt.from(ingame_stats_object.currentPrestigePoint)*BigInt.from(3).pow(EggIndexList[index].level - 1)~/(BigInt.from(10));
    return sonuc;
  }

  BigInt calculateMoneyPerSec() {
    BigInt result = BigInt.zero;
    for (int n = 0; n < 20; n++) {
      if (EggIndexList[n].level > 0) {
        result += produceMoney(n);
      }
    }
    return result;
  }

  double spawnerPercent = 0;

  //MODELI INIT ETTIGIMIZDE BASLAYAN TIMERLAR
  EggObjectModel() {
    loadTheGame(); //oyunu bir yüklüyoruz burada.

    for (int n = 0; n < 20; n++) {
      EggIndexList.add(EggObject());
    }

    for (int n = 1; n <= 27; n++) {
      ImageRoutes.add("ourAssets/images/eggs/${n}.png");
    }

    //PRODUCİNG MONEY HERE
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ingame_stats_object.moneyPerSec = calculateMoneyPerSec();
      ingame_stats_object.totalMoney += ingame_stats_object.moneyPerSec;
      ingame_stats_object.allTimeMoney += ingame_stats_object.moneyPerSec;
      //prestige calculation
      ingame_stats_object.calculatePrestigePoint();

      //save the fame function is should be here
      saveTheGame();

      //all time egg leveli burada hesaplıyorum.
      for (int n = 0; n < 20; n++) {
        if (EggIndexList[n].level > ingame_stats_object.allTimeEggLevel) {
          ingame_stats_object.allTimeEggLevel = EggIndexList[n].level;
        }
      }
      notifyListeners();
    });
    //SPAWNER COUNTER ANİMATİON
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      bool willSpawnKontrol = false;
      for (int n = 0; n < 20; n++) {
        //dolu mu boş mu layler ona göre
        if (EggIndexList[n].level == 0) {
          willSpawnKontrol = true;
          break;
        }
      }
      if (willSpawnKontrol) {
        spawnerPercent = 1.0 -
            upgrade_stats_object.spawn_time_counter /
                upgrade_stats_object.spawn_time;

        upgrade_stats_object.spawn_time_counter -=
            1; // bu da spawner değişkenlerine bağlı
        if (upgrade_stats_object.spawn_time_counter <= 0) {
          for (int n = 0; n < 20; n++) {
            if (EggIndexList[n].level == 0) {
              EggIndexList[n].level += upgrade_stats_object.base_egg_level;
              break;
            }
          }
          upgrade_stats_object.spawn_time_counter =
              upgrade_stats_object.spawn_time;
        }
      }
      notifyListeners();
    });
    //SPAWNİNG AN EGG AND CHECKİNG
  }

  //DragTarget oluşturuyor egglist'teki indexlerden index değeri alıyor ona göre işlem yapıyor.
  Widget printDragTargetEggWidget(int thisObjectIndex) {
    return Consumer<EggObjectModel>(builder: ((context, value, child) {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
          if (value.EggIndexList[thisObjectIndex].level == 0) {
            return EmptyPlaceHolderWidget();
          } else {
            return Container(
              decoration: BoxDecoration(color: Colors.transparent,),
              width: 60,
              height: 60,
              child: Draggable<int>(
                data: thisObjectIndex,
                childWhenDragging: EmptyPlaceHolderWidget(),
                feedback: Container(
                  width: 60,
                  height: 60,
                  child: Image.asset(ImageRoutes[
                      value.EggIndexList[thisObjectIndex].level - 1]),
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(ImageRoutes[
                          value.EggIndexList[thisObjectIndex].level - 1],width: 60,height: 60,),
                      Container(
                          width: 60,
                          height: 60,
                          color: Colors.transparent,
                          child: Text(
                            bigIntToString(produceMoney(thisObjectIndex)),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 72, 168, 75),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(
                                      0.0, 0.0), // Gölgeyi sağa ve aşağı kaydır
                                  blurRadius: 6.0, // Gölge bulanıklığı
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.472), // Gölge rengi
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        // index bulunduğumuz widgetin listedeki konumu gelen bilgi ise karşı tarafın bulunduğu konum
        onAcceptWithDetails: (DragTargetDetails<Object?> details) {
          int draggedObjectData = details.data as int;
          if (value.EggIndexList[draggedObjectData].level ==
                  value.EggIndexList[thisObjectIndex].level &&
              draggedObjectData != thisObjectIndex) {
            value.EggIndexList[thisObjectIndex].level++;
            value.EggIndexList[draggedObjectData].level = 0;
          } else if (value.EggIndexList[thisObjectIndex].level == 0 &&
              value.EggIndexList[draggedObjectData].level != 0) {
            value.EggIndexList[thisObjectIndex].level =
                value.EggIndexList[draggedObjectData].level;
            value.EggIndexList[draggedObjectData].level = 0;
          }
          value.notifyListeners();
        },
      );
    }));
  }
}

class EmptyPlaceHolderWidget extends StatelessWidget {
  const EmptyPlaceHolderWidget({super.key});

  @override
  Widget build(context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0),color: Colors.black12),
    );
  }
}
