import 'dart:convert';

import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


void saveTheGame(UpgradeStats upgrade_stats_object, InGameStatsObject ingame_stats_object,List<EggObject> EggIndexList) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    //UPGRADE STATS
    storage.setInt("base_egg_level", upgrade_stats_object.base_egg_level);
    storage.setString("base_egg_level_increase_cost",upgrade_stats_object.base_egg_level_increase_cost.toString());
    storage.setDouble("spawn_time", upgrade_stats_object.spawn_time);
    storage.setDouble("spawn_time_counter", upgrade_stats_object.spawn_time_counter);
    storage.setInt("spawn_time_decreaser_amount",upgrade_stats_object.spawn_time_decreaser_amount);
    storage.setString("spawn_time_decreaser_cost", upgrade_stats_object.spawn_time_decreaser_cost.toString());
    storage.setString("double_egg_cost", upgrade_stats_object.double_egg_increaser_cost.toString());
    storage.setInt("double_egg_amount",upgrade_stats_object.double_egg_increaser_amount);
    storage.setInt("wing_at_merge_amount",upgrade_stats_object.wing_at_merge_amount);
    storage.setString("wing_at_merge_cost",upgrade_stats_object.wing_at_merge_cost.toString());
    //INGAME STATS
    storage.setInt("allAllTimeEggLevel",ingame_stats_object.allAllTimeEggLevel);
    storage.setInt("merge_level_current",ingame_stats_object.merge_level_current);
    storage.setInt("merge_level_required",ingame_stats_object.merge_level_required);
    storage.setInt("merge_level_merged",ingame_stats_object.merge_level_merged);
    storage.setInt("merge_level_up_reward",ingame_stats_object.merge_level_up_reward);
    storage.setString("all_all_time_merge", ingame_stats_object.all_time_merge.toString());

    storage.setInt("game_progression_leve",ingame_stats_object.gameProgressionLevel);

    storage.setInt("current_prestige_amount",ingame_stats_object.currentPrestigePoint);
    storage.setInt("allTimeEggLevel", ingame_stats_object.allTimeEggLevel);
    storage.setInt("willGainAmountPrestigePoint", ingame_stats_object.willGainAmountPrestigePoint);
    storage.setString("allAllTimeMoney", ingame_stats_object.allAllTimeMoney.toString());
    storage.setString("totalMoney", ingame_stats_object.totalMoney.toString());
    storage.setString("allTimeMoney", ingame_stats_object.allTimeMoney.toString());
    storage.setInt("golden_wing", ingame_stats_object.goldenWing);

    storage.setDouble("merge_level_up_percent", ingame_stats_object.merge_level_percent);

    String eggLevelsString="";
    for(int n=0;n<20;n++){
      eggLevelsString+=EggIndexList[n].level.toString() + "."; // from 0 to 19 
    }
    storage.setString("EggIndexListString", eggLevelsString);

  }


late Map<String, Object> data = {};


void loadTheGame(UpgradeStats upgrade_stats_object, InGameStatsObject ingame_stats_object, List<EggObject> EggIndexList) async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    //UPGRADE STATS
    upgrade_stats_object.double_egg_increaser_amount = storage.getInt("double_egg_amount")??0;
    upgrade_stats_object.double_egg_increaser_cost = BigInt.parse(storage.getString("double_egg_cost").toString());
    upgrade_stats_object.base_egg_level = storage.getInt("base_egg_level") ?? 1;
    upgrade_stats_object.base_egg_level_increase_cost = BigInt.parse(storage.getString("base_egg_level_increase_cost").toString());
    upgrade_stats_object.spawn_time = storage.getDouble("spawn_time") ?? UpgradeStats().spawn_time;
    upgrade_stats_object.spawn_time_counter = storage.getDouble("spawn_time_counter") ?? UpgradeStats().spawn_time_counter;
    upgrade_stats_object.spawn_time_decreaser_amount = storage.getInt("spawn_time_decreaser_amount") ?? 0;
    upgrade_stats_object.spawn_time_decreaser_cost = BigInt.parse(storage.getString("spawn_time_decreaser_cost").toString());
    upgrade_stats_object.wing_at_merge_amount = storage.getInt("wing_at_merge_amount") ?? 0;
    upgrade_stats_object.wing_at_merge_cost= BigInt.parse(storage.getString("wing_at_merge_cost").toString());

    //Ingame stats
    ingame_stats_object.gameProgressionLevel = storage.getInt("game_progression_level") ?? 0;

    ingame_stats_object.allAllTimeEggLevel = storage.getInt("allAllTimeEggLevel")??1;
    ingame_stats_object.all_time_merge = BigInt.parse(storage.getString("all_all_time_merge").toString());
    ingame_stats_object.merge_level_current=storage.getInt("merge_level_current") ?? 1;
    ingame_stats_object.merge_level_required=storage.getInt("merge_level_required") ?? 5;
    ingame_stats_object.merge_level_merged=storage.getInt("merge_level_merged") ?? 0;
    ingame_stats_object.merge_level_up_reward=storage.getInt("merge_level_up_reward") ?? 5;
    ingame_stats_object.merge_level_percent = storage.getDouble("merge_level_up_percent")??0.0;
    ingame_stats_object.currentPrestigePoint= storage.getInt("current_prestige_amount") ?? 0;
    ingame_stats_object.allTimeEggLevel= storage.getInt("allTimeEggLevel") ?? 1;
    ingame_stats_object.willGainAmountPrestigePoint= storage.getInt("willGainAmountPrestigePoint") ?? 0;

    ingame_stats_object.goldenWing = storage.getInt("golden_wing")??0;
    ingame_stats_object.totalMoney = BigInt.parse(storage.getString("totalMoney").toString());
    ingame_stats_object.allTimeMoney = BigInt.parse(storage.getString("allTimeMoney").toString());
    ingame_stats_object.allAllTimeMoney = BigInt.parse(storage.getString("allAllTimeMoney").toString());

    String eggIndexListString0=storage.getString("EggIndexListString")??"0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.";
    List<String> eggIndexListString1=eggIndexListString0.split(".");
    for(int n=0;n<20;n++){
      EggIndexList[n].level = int.parse(eggIndexListString1[n]);
    }


    var dataString = storage.getString("data");
    data = dataString != null
        ? Map<String, Object>.from(jsonDecode(dataString))
        : {};
  }