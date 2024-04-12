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

List<String>ImageRoutes=[
    "ourAssets/images/animal.png",
    "ourAssets/images/easter.png",
    "ourAssets/images/egg.png",
    "ourAssets/images/hen.png",
    "ourAssets/images/money.png",
    "ourAssets/images/upgrade.png",
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

  //DragTarget oluşturuyor egglist'teki indexlerden index değeri alıyor ona göre işlem yapıyor.
  Widget printDragTargetEggWidget(int thisObjectIndex) {
    return Consumer<EggObjectModel>(builder: ((context, value, child) {
      return DragTarget(
        builder: (context, candidateData, rejectedData) {
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
                child: Image.asset(ImageRoutes[value.EggIndexList[thisObjectIndex].level]),
              ),
              feedback: Container(
                width: 50,
                height: 50,
                child: Image.asset('ourAssets/images/egg.png'),
              ),
            ),
          );
        },
        // index bulunduğumuz widgetin listedeki konumu gelen bilgi ise karşı tarafın bulunduğu konum
          onAcceptWithDetails: (DragTargetDetails<Object?> details) {
          int draggedObjectData = details.data as int;
            if(value.EggIndexList[draggedObjectData].level == value.EggIndexList[thisObjectIndex].level){
              print('tebrikler');
              value.EggIndexList[thisObjectIndex].level++;
              value.EggIndexList[draggedObjectData].level = 0;
            }
          print(value.EggIndexList[draggedObjectData].level.toString());
          print(value.EggIndexList[thisObjectIndex].level.toString());
          value.notifyListeners();
        },
      );
    }));
  }
}
