/*
shared preferences road

first create a sharedpreferences object in model.

then create a function that takes that object plus other classes that you store thing.

in that function you are going to save everything.


*/
import 'dart:math';

import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EggObject {
  int level = 0;
}
List<EggObject> EggIndexList = [];


class UpgradeStats {
  int base_egg_level = 1;
  int base_egg_level_increase_cost = 20000;

  void setNewBaseEggLevel() {
    base_egg_level_increase_cost *= 4;
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


  int allTimeEggLevel=0;


  num allTimeMoney=0;
  int willGainAmountPrestigePoint=0;
  int currentPrestigePoint=0;

  void calculatePrestigePoint(){
    willGainAmountPrestigePoint = sqrt(allTimeMoney)~/100; // buradaki oran değiştirilebilir şimdilik iki dedim bakalım nasıl olacak.
  }
  void prestigeFunction(List<EggObject> eggIndexList,UpgradeStats upgradeStats){
    currentPrestigePoint += willGainAmountPrestigePoint;
    totalMoney = 0;
    moneyPerSec = 0;
    allTimeMoney=0;
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
    upgrade_stats_object.spawn_time_counter -= 10.0;
    upgrade_stats_object.spawn_time -= 10.0;
    upgrade_stats_object.spawn_time_decreaser_cost *= 2;
    upgrade_stats_object.spawn_time_decreaser_amount += 1;
  }


void saveTheGame(SharedPreferences storage){

}


void resetUpgradeStats(UpgradeStats upgradeStats){
  upgradeStats.base_egg_level = 1;
  upgradeStats.base_egg_level_increase_cost = 20000;

  //TODO EĞER OYUN KASARSA TELEFONDAYKEN BUNU 400 DEĞİL 40 yap ve aşağıdaki timer'ı da onla çarps.
  upgradeStats.spawn_time_decreaser_amount = 1;
  upgradeStats.spawn_time = 400.0;
  upgradeStats.spawn_time_counter = 400.0;
  upgradeStats.spawn_time_decreaser_cost = 1000;
}