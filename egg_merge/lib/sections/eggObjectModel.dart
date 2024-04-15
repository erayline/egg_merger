import 'dart:async';

import 'package:egg_merge/sections/eggClass.dart';
import 'package:egg_merge/sections/rootInfos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EggObject {
  int baseEarning = 1;
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

List<String> ImageRoutes = [
  "ourAssets/images/animal.png",
  "ourAssets/images/easter.png",
  "ourAssets/images/egg.png",
  "ourAssets/images/hen.png",
  "ourAssets/images/money.png",
  "ourAssets/images/upgrade.png",
  "ourAssets/images/chicken-wings.png",
];

class EggObjectModel extends ChangeNotifier {
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

  List<bool> EggIsDragtarget = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  int produceMoney(int index) {
    int sonuc = EggIndexList[index].baseEarning ^ EggIndexList[index].level;
    return sonuc;
  }

  int counter=4;
  EggObjectModel(){
    Timer.periodic(Duration(seconds: 1), (timer) {
        counter--;
        if(counter == 0){
          counter = 4;
        }
        notifyListeners();
      });
    Timer.periodic(Duration(seconds: 4), (timer) {
        for (int n = 0; n < 20; n++) {
          if (EggIndexList[n].level == 0) {
            EggIndexList[n].level += 1;
            break;
          }
        }
        notifyListeners();
      });
  }

  // Timer _timer1;
  // void initSpawner(int sec){
  //   _timer1.periodic(Duration(seconds: 1), (timer) {
  //       counter--;
  //       if(counter == 0){
  //         counter = sec;
  //       }
  //       notifyListeners();
  //     });
  //   Timer _timer2 = Timer.periodic(Duration(seconds: sec), (timer) {
  //       for (int n = 0; n < 20; n++) {
  //         if (EggIndexList[n].level == 0) {
  //           EggIndexList[n].level += 1;
  //           break;
  //         }
  //       }
  //       notifyListeners();
  //     });
  // }
  // void disposeSpawner(){
  //   _timer1.cancel();
  // }


  //DragTarget oluşturuyor egglist'teki indexlerden index değeri alıyor ona göre işlem yapıyor.
  Widget printDragTargetEggWidget(int thisObjectIndex) {
    return Consumer<EggObjectModel>(builder: ((context, value, child) {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
          if (value.EggIndexList[thisObjectIndex].level == 0) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.black12,
            );
          } else {
            return Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: Draggable<int>(
                data: thisObjectIndex,
                childWhenDragging: Container(
                  width: 50,
                  height: 50,
                  color: Colors.black12,
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(ImageRoutes[
                      value.EggIndexList[thisObjectIndex].level - 1]),
                ),
                feedback: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(ImageRoutes[
                      value.EggIndexList[thisObjectIndex].level - 1]),
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