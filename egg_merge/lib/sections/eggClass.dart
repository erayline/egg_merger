import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class EggClass extends ChangeNotifier {
  int level = 1;
  bool dragTargetOpen = false;

  int produceMoney() {
    int result;
    result = 3 ^ (this.level - 1);
    return result;
  }
  
  void changeLevel(int newLevel){
    Consumer<EggClass>(builder: ((context, value, child) {
          value.level += 1;
          value.notifyListeners();
          return Text('e');
      }));
  }

  void changeDragTarget() {
    this.dragTargetOpen = !this.dragTargetOpen;
    notifyListeners();
  }

  //TODO: ASSET İSİM LİSTESİ İLE DEĞİŞTİRİLECEK
  Widget printEgg() {
    return Consumer<EggClass>(builder: ((context, value, child) {
      if (value.level == 0) {
        return Container(
          width: 60,
          height: 60,
          color: Colors.black12,
        );
      } else {
        return Text(value.level.toString());
      }
    }));
  }
}

EggClass egg_0 = new EggClass();
EggClass egg_1 = new EggClass();
EggClass egg_2 = new EggClass();
EggClass egg_3 = new EggClass();
EggClass egg_4 = new EggClass();
EggClass egg_5 = new EggClass();
EggClass egg_6 = new EggClass();
EggClass egg_7 = new EggClass();
EggClass egg_8 = new EggClass();
EggClass egg_9 = new EggClass();
EggClass egg_10 = new EggClass();
EggClass egg_11 = new EggClass();
EggClass egg_12 = new EggClass();
EggClass egg_13 = new EggClass();
EggClass egg_14 = new EggClass();
EggClass egg_15 = new EggClass();
EggClass egg_16 = new EggClass();
EggClass egg_17 = new EggClass();
EggClass egg_18 = new EggClass();
EggClass egg_19 = new EggClass();

List<EggClass> yumurtalarListesi = [
  egg_19,
  egg_18,
  egg_17,
  egg_16,
  egg_15,
  egg_14,
  egg_13,
  egg_12,
  egg_11,
  egg_10,
  egg_9,
  egg_8,
  egg_7,
  egg_6,
  egg_5,
  egg_4,
  egg_3,
  egg_2,
  egg_1,
  egg_0
];
