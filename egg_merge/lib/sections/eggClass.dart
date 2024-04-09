import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List <int> idler=[
  0,0,2,0,
  0,0,0,0,
  0,0,0,0,
  0,0,0,0,
  0,0,0,0
];


class EggClass{
  int level = 0;

  EggClass(int this.level){
    this.level=level;
  }

  int produceMoney(){
    int result;
    result = 3^(this.level-1);
    return result;
  }

  //TODO: ASSET İSİM LİSTESİ İLE DEĞİŞTİRİLECEK
  Widget printEgg(){
    if (this.level == 0){
      return Container(
        width: 50,height: 50,
        color:Colors.transparent,
        child: Image.asset('ourAssets/images/egg.png'),
      );
    }else{
      return Container(
        width: 50,height: 50,
        child: Image.asset('ourAssets/images/animal.png'),
      );
    }
  }
}


EggClass egg_0 = new EggClass(0);
EggClass egg_1 = new EggClass(0);
EggClass egg_2 = new EggClass(0);
EggClass egg_3 = new EggClass(0);
EggClass egg_4 = new EggClass(0);
EggClass egg_5 = new EggClass(0);
EggClass egg_6 = new EggClass(0);
EggClass egg_7 = new EggClass(0);
EggClass egg_8 = new EggClass(0);
EggClass egg_9 = new EggClass(0);
EggClass egg_10 = new EggClass(1);
EggClass egg_11 = new EggClass(0);
EggClass egg_12 = new EggClass(0);
EggClass egg_13 = new EggClass(1);
EggClass egg_14 = new EggClass(0);
EggClass egg_15 = new EggClass(0);
EggClass egg_16 = new EggClass(1);
EggClass egg_17 = new EggClass(0);
EggClass egg_18 = new EggClass(1);
EggClass egg_19 = new EggClass(0);

List <EggClass> yumurtalar = [
  egg_19,egg_18,egg_17,egg_16,
  egg_15,egg_14,egg_13,egg_12,
  egg_11,egg_10,egg_9,egg_8,
  egg_7,egg_6,egg_5,egg_4,
  egg_3,egg_2,egg_1,egg_0
];