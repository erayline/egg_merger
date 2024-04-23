/*
shared preferences road

first create a sharedpreferences object in model.

then create a function that takes that object plus other classes that you store thing.

in that function you are going to save everything.


*/
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:shared_preferences/shared_preferences.dart';





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