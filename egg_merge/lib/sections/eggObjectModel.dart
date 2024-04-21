import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UpgradeStats {
  int base_egg_level = 1;
  int base_egg_level_increase_cost = 20000;

  void setNewBaseEggLevel() {
    base_egg_level_increase_cost *= 3;
  }

  //TODO EĞER OYUN KASARSA TELEFONDAYKEN BUNU 400 DEĞİL 40 yap ve aşağıdaki timer'ı da onla çarps.
  int spawn_time_decreaser_amount = 1;
  double spawn_time = 400.0;
  double spawn_time_counter = 400.0;
  int spawn_time_decreaser_cost = 1000;
}

class InGameStatsObject{
  num totalMoney = 0;
  num moneyPerSec = 0;


  num allTimeMoney=0;
  int willGainAmountPrestigePoint=0;
  int currentPrestigePoint=0;

  void calculatePrestigePoint(){
    willGainAmountPrestigePoint = sqrt(allTimeMoney)~/100; // buradaki oran değiştirilebilir şimdilik iki dedim bakalım nasıl olacak.
  }
  void prestigeFunction(List<EggObject> eggIndexList){
    currentPrestigePoint += willGainAmountPrestigePoint;
    totalMoney = 0;
    moneyPerSec = 0;
    allTimeMoney=0;
    willGainAmountPrestigePoint=0;
    for(int n=0;n<20;n++){
      eggIndexList[n].level = 0;
    }
  }
}

class EggObject {
  int level = 0;
}

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

//IMAGE STRINGLERI
List<String> ImageRoutes = [];

class EggObjectModel extends ChangeNotifier {
//YUMURTA OBJELERININI BARINDIRIYOR INDEX'E GORE ISLEM YAPIYORUZ
  List<EggObject> EggIndexList = [];

  UpgradeStats upgrade_stats_object = new UpgradeStats();
  InGameStatsObject ingame_stats_object = new InGameStatsObject();


  void increaseBaseEgg() {
    upgrade_stats_object.base_egg_level++;
    ingame_stats_object.totalMoney -= upgrade_stats_object.base_egg_level_increase_cost.toInt();
    upgrade_stats_object.setNewBaseEggLevel();

    for (int n = 0; n < 20; n++) {
      if (EggIndexList[n].level < upgrade_stats_object.base_egg_level &&
          EggIndexList[n].level != 0) {
        EggIndexList[n].level = upgrade_stats_object.base_egg_level;
      }
    }

    notifyListeners();
  }

  void buy_decrease_spawn_time() {
    ingame_stats_object.totalMoney -= upgrade_stats_object.spawn_time_decreaser_cost;
    upgrade_stats_object.spawn_time_counter -= 10.0;
    upgrade_stats_object.spawn_time -= 10.0;
    upgrade_stats_object.spawn_time_decreaser_cost *= 2;
    upgrade_stats_object.spawn_time_decreaser_amount += 1;
  }
  //OYUN ICI DEGISKENLER

  //BU IKISI PARA URETIMINDEN SORUMLU
  num produceMoney(int index) {
    num sonuc = pow(3, EggIndexList[index].level - 1) + pow(3, EggIndexList[index].level - 1)*(ingame_stats_object.currentPrestigePoint.toDouble()/10);
    return sonuc;
  }

  num calculateMoneyPerSec() {
    num result = 0;
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
    for (int n = 0; n < 20; n++) {
      EggIndexList.add(EggObject());
    }

    for (int n = 1; n <= 18; n++) {
      ImageRoutes.add("ourAssets/images/eggs/${n}.png");
    }

    //PRODUCİNG MONEY HERE
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ingame_stats_object.moneyPerSec = calculateMoneyPerSec();
      ingame_stats_object.totalMoney += ingame_stats_object.moneyPerSec;
      ingame_stats_object.allTimeMoney += ingame_stats_object.moneyPerSec;
      //prestige calculation
      ingame_stats_object.calculatePrestigePoint();

      notifyListeners();
    });
    //SPAWNER COUNTER ANİMATİON
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      bool willSpawnKontrol = false;
      for(int n=0;n<20;n++){
        if(EggIndexList[n].level==0){
          willSpawnKontrol=true;
          break;
        }
      }
      if(willSpawnKontrol){
        spawnerPercent = 1.0 - upgrade_stats_object.spawn_time_counter / upgrade_stats_object.spawn_time;
        upgrade_stats_object.spawn_time_counter -= 1; // bu da spawner değişkenlerine bağlı
        if (upgrade_stats_object.spawn_time_counter <= 0) {
          for (int n = 0; n < 20; n++) {
            if (EggIndexList[n].level == 0) {
              EggIndexList[n].level += upgrade_stats_object.base_egg_level;
              break;
            }
          }
          upgrade_stats_object.spawn_time_counter = upgrade_stats_object.spawn_time;
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
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: Draggable<int>(
                data: thisObjectIndex,
                childWhenDragging: EmptyPlaceHolderWidget(),
                feedback: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(ImageRoutes[
                      value.EggIndexList[thisObjectIndex].level - 1]),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(ImageRoutes[
                          value.EggIndexList[thisObjectIndex].level - 1]),
                      Positioned(
                          child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.transparent,
                              child: Text(
                                produceMoney(thisObjectIndex).toStringAsFixed(0),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 72, 168, 75),
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0.0,
                                          0.0), // Gölgeyi sağa ve aşağı kaydır
                                      blurRadius: 6.0, // Gölge bulanıklığı
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.472), // Gölge rengi
                                    ),
                                  ],
                                ),
                              ))),
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
      width: 50,
      height: 50,
      color: Colors.black12,
    );
  }
}
