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
    base_egg_level_increase_cost *= 2;
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
List<String> ImageRoutes=[];

class EggObjectModel extends ChangeNotifier {
//YUMURTA OBJELERININI BARINDIRIYOR INDEX'E GORE ISLEM YAPIYORUZ
  List<EggObject> EggIndexList = [
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
    EggObject(),
  ];

  UpgradeStats upgrade_stats_object = new UpgradeStats();

  void increaseBaseEgg() {
    upgrade_stats_object.base_egg_level++;
    totalMoney -= upgrade_stats_object.base_egg_level_increase_cost.toInt();
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

  //BU IKISI PARA URETIMINDEN SORUMLU
  int produceMoney(int index) {
    num sonuc = pow(3, EggIndexList[index].level - 1);
    return sonuc.toInt();
  }

  int calculateMoneyPerSec() {
    int result = 0;
    for (int n = 0; n < 20; n++) {
      if (EggIndexList[n].level > 0) {
        result += produceMoney(n);
      }
    }
    return result;
  }

  int totalMoney = 0;
  int moneyPerSec = 0;

  double counter = 5.0;
  double spawnerPercent = 0;

  //MODELI INIT ETTIGIMIZDE BASLAYAN TIMERLAR
  EggObjectModel() {
    for(int n=1;n<=18;n++){
      ImageRoutes.add("ourAssets/images/eggs/${n}.png");
    }


    //PRODUCİNG MONEY HERE
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      moneyPerSec = calculateMoneyPerSec();
      totalMoney += moneyPerSec;
      notifyListeners();
    });
    //SPAWNER COUNTER ANİMATİON
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      spawnerPercent = 1 - counter.toDouble() / 7;
      counter -= 1;
      if (counter == 0) {
        Future.delayed(Duration(milliseconds: 1000), () {
          counter = 5;
        });
      }
      notifyListeners();
    });
    //SPAWNİNG AN EGG AND CHECKİNG
    Timer.periodic(Duration(milliseconds: 6000), (timer) {
      Future.delayed(Duration(seconds: 1), () {
        for (int n = 0; n < 20; n++) {
          if (EggIndexList[n].level == 0) {
            EggIndexList[n].level += upgrade_stats_object.base_egg_level;
            break;
          }
        }
      });
      notifyListeners();
    });
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
                                produceMoney(thisObjectIndex).toString(),
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
