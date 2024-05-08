import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:egg_merge/funcsFolder/saveload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

int goldenPenKatsayisi = 1;

  //BU IKISI PARA URETIMINDEN SORUMLU
  BigInt produceMoney(int index) {
    BigInt sonuc = BigInt.from(3).pow(EggIndexList[index].level - 1) + BigInt.from(ingame_stats_object.currentPrestigePoint)*BigInt.from(3).pow(EggIndexList[index].level - 1)*BigInt.from(goldenPenKatsayisi)~/(BigInt.from(100));
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
    loadTheGame(upgrade_stats_object, ingame_stats_object, EggIndexList); //oyunu bir yüklüyoruz burada.

    for (int n = 0; n < 20; n++) {
      EggIndexList.add(EggObject());
    }

    for (int n = 1; n <= gameEggCount; n++) {
      ImageRoutes.add("ourAssets/images/eggs/${n}.png");
    }

    //PRODUCİNG MONEY HERE
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ingame_stats_object.moneyPerSec = calculateMoneyPerSec();
      ingame_stats_object.totalMoney += ingame_stats_object.moneyPerSec;
      ingame_stats_object.allTimeMoney += ingame_stats_object.moneyPerSec;
      ingame_stats_object.allAllTimeMoney += ingame_stats_object.moneyPerSec;
      //prestige calculation
      ingame_stats_object.calculatePrestigePoint();

      //save the fame function is should be here
      saveTheGame(upgrade_stats_object, ingame_stats_object, EggIndexList);

      //all time egg leveli burada hesaplıyorum.
      for (int n = 0; n < 20; n++) {
        if (EggIndexList[n].level > ingame_stats_object.allTimeEggLevel) {
          ingame_stats_object.allTimeEggLevel = EggIndexList[n].level;
          if(ingame_stats_object.allAllTimeEggLevel<ingame_stats_object.allTimeEggLevel){
            ingame_stats_object.allAllTimeEggLevel=ingame_stats_object.allTimeEggLevel;
          }
        }
      }
      notifyListeners();
    });
    //SPAWNER COUNTER ANİMATİON
    Timer.periodic(Duration(milliseconds: 100), (timer) {

      if (isThereEmptySpace(EggIndexList)) {
        spawnerPercent = 1.0 - double.parse((upgrade_stats_object.spawn_time_counter / upgrade_stats_object.spawn_time).toStringAsFixed(2));
        upgrade_stats_object.spawn_time_counter-=0.1;
        if(upgrade_stats_object.spawn_time_counter<0){upgrade_stats_object.spawn_time_counter=0.0;}; // bu da spawner değişkenlerine bağlı

        if (upgrade_stats_object.spawn_time_counter <= 0) {
          spawnOneEgg(upgrade_stats_object, EggIndexList);
          //spawn ikinciyi.
          if(willItHappen(upgrade_stats_object.double_egg_increaser_amount)){
            spawnOneEgg(upgrade_stats_object, EggIndexList);
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
              width: 70,
              height: 70,
              child: Draggable<int>(
                data: thisObjectIndex,
                childWhenDragging: EmptyPlaceHolderWidget(),
                feedback: Container(
                  width: 80,
                  height: 80,
                  child: Image.asset(ImageRoutes[
                      value.EggIndexList[thisObjectIndex].level - 1],),
                ),
                child: Container(
                  width: 70,
                  
                  height: 70,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(ImageRoutes[
                          value.EggIndexList[thisObjectIndex].level - 1],width: 70,height: 70,),
                      Positioned(
                        top: 52,
                        left: 5,
                        child: Container(
                            width: 70,
                            height: 70,
                            color: Colors.transparent,
                            child: Text(
                              bigIntToString(produceMoney(thisObjectIndex)),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                shadows: [
                                  Shadow(
                                    offset: Offset(
                                        0.0, 0.0), // Gölgeyi sağa ve aşağı kaydır
                                    blurRadius: 14.0, // Gölge bulanıklığı
                                    color: Color.fromRGBO(124, 0, 0, 0.824), // Gölge rengi
                                  ),
                                ],
                              ),
                            )
                          ),
                      ),
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

          //WİLL MERGE
          if (value.EggIndexList[draggedObjectData].level == value.EggIndexList[thisObjectIndex].level && draggedObjectData != thisObjectIndex && value.EggIndexList[thisObjectIndex].level!=gameEggCount) {

            atMergeFunction(ingame_stats_object, upgrade_stats_object, EggIndexList, thisObjectIndex, draggedObjectData);
          
          } 
          // WİLL CHANGE POSİTİON
          else if (value.EggIndexList[thisObjectIndex].level == 0 && value.EggIndexList[draggedObjectData].level != 0) {
            value.EggIndexList[thisObjectIndex].level = value.EggIndexList[draggedObjectData].level;
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
      width: 70,
      height: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0),color: Colors.black12),
    );
  }
}
