/*
shared preferences road

first create a sharedpreferences object in model.

then create a function that takes that object plus other classes that you store thing.

in that function you are going to save everything.


*/
import 'dart:math';

import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';





class UpgradeStats {
  int base_egg_level = 1;
  BigInt base_egg_level_increase_cost = BigInt.from(20000);

  void setNewBaseEggLevel() {
    base_egg_level_increase_cost *= BigInt.from(4);
  }

  //TODO EĞER OYUN KASARSA TELEFONDAYKEN BUNU 400 DEĞİL 40 yap ve aşağıdaki timer'ı da onla çarps.
  int spawn_time_decreaser_amount = 0;
  double spawn_time = 40.0;
  double spawn_time_counter = 40.0;
  BigInt spawn_time_decreaser_cost = BigInt.from(1000);
}


class InGameStatsObject{

  BigInt totalMoney = BigInt.from(1);
  BigInt moneyPerSec = BigInt.from(1);

  BigInt allTimeMoney = BigInt.from(1);
  int allTimeEggLevel=0;


  int willGainAmountPrestigePoint=0;
  int currentPrestigePoint=0;

  void calculatePrestigePoint(){
    if(BigInt.zero<=allTimeMoney && allTimeMoney<= BigInt.from(10).pow(6)){
      willGainAmountPrestigePoint =0;
    }else if(BigInt.from(10).pow(6)<=allTimeMoney && allTimeMoney<= BigInt.from(10).pow(10)){
      willGainAmountPrestigePoint= pow(5, 2).toInt();
    }else if(BigInt.from(10).pow(10)<=allTimeMoney && allTimeMoney<= BigInt.from(10).pow(14)){
      willGainAmountPrestigePoint= pow(5, 4).toInt();
    }else if(BigInt.from(10).pow(14)<=allTimeMoney && allTimeMoney<= BigInt.from(10).pow(18)){
      willGainAmountPrestigePoint=pow(5, 6).toInt();
    }else if(BigInt.from(10).pow(18)<=allTimeMoney && allTimeMoney<= BigInt.from(10).pow(22)){
      willGainAmountPrestigePoint= pow(5, 8).toInt();
    }else if(BigInt.from(10).pow(22)<=allTimeMoney && allTimeMoney<= BigInt.from(10).pow(26)){
      willGainAmountPrestigePoint= pow(5, 10).toInt();
    }

  }
  void prestigeFunction(List<EggObject> eggIndexList,UpgradeStats upgradeStats){
    currentPrestigePoint += willGainAmountPrestigePoint;
    totalMoney = BigInt.zero;
    moneyPerSec = BigInt.zero;
    allTimeMoney=BigInt.zero;
    willGainAmountPrestigePoint=0;

    resetUpgradeStats(upgradeStats);

    for(int n=0;n<20;n++){
      eggIndexList[n].level = 0;
    }
  }
}


List<String> ImageRoutes = [];

void buy_decrease_spawn_time(UpgradeStats upgrade_stats_object,InGameStatsObject ingame_stats_object) {
    ingame_stats_object.totalMoney -= upgrade_stats_object.spawn_time_decreaser_cost;
    upgrade_stats_object.spawn_time_counter -= 1.0;
    upgrade_stats_object.spawn_time -= 1.0;
    upgrade_stats_object.spawn_time_decreaser_cost *= BigInt.from(2);
    upgrade_stats_object.spawn_time_decreaser_amount += 1;
  }


void resetUpgradeStats(UpgradeStats upgradeStats){
  upgradeStats.base_egg_level = 1;
  upgradeStats.base_egg_level_increase_cost = BigInt.from(20000);

  //TODO EĞER OYUN KASARSA TELEFONDAYKEN BUNU 400 DEĞİL 40 yap ve aşağıdaki timer'ı da onla çarps.
  upgradeStats.spawn_time_decreaser_amount = 0;
  upgradeStats.spawn_time = 40.0;
  upgradeStats.spawn_time_counter = 40.0;
  upgradeStats.spawn_time_decreaser_cost = BigInt.from(1000);
}