import 'dart:math';
import 'package:egg_merge/funcsFolder/gods.dart';
import 'package:egg_merge/funcsFolder/reklam.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';


int gameEggCount=93;
List<String> eggNames = [
  "You are\nmy first",
  "Bluer",
  "Warning!",
  "Where am I?",
  "Red Moon", //5
  "Eat It",
  "Blooming",
  "Secret",
  "Beaten One",
  "Meltable", // 10
  "Jumpy",
  "100 at\na Time",
  "Confetti",
  "Mother\nOf All",
  "Channel 8", //15
  "Planty Egg",
  "River",
  "Not Gold",
  "Moony",
  "Holly Egg!?", //20
  "Brown Joy",
  "Eggzotic Sound",
  "Biom x-3",
  "Forest Path",
  "Wait what?", // 25
  "Captain Egg",
  "Egguin",
  "African", // değiştir bunu
  "Listen yourself",
  "Japan work", //30
  "Let me\neat too",
  "Give me egg",
  "Stay still",
  "where are\nthe eggs?",
  "Present", //35
  "Prince",
  "Perfect Combo",
  "Eggsplosive",
  "mEggic",
  "Snow Bunny", //40
  "\$FINALLY\$",
  "Pluto",
  "Was it\nall lie?",
  "Stay away",
  "3.99\$", //45
  "Hi you",
  "Arctic",
  "Fat one",
  "Eggable\nplayer",
  "Egg from\nspace", //50
  "Wounds needs\ntime",
  "Mottled",
  "Fancy",
  "Expensive",
  "Studentish",//55
  "Aurora",
  "Expired",
  "Final\nDestination",
  "Not an egg",
  "Fried Egg?", //60
  "Kepler",
  "Mixed",
  "Mysterious",
  "Flying Egg",
  "Music reminder:)", //65
  "Layed 1000\negg",
  "Ocean",
  "Peace",
  "Love me!", //70
  "No!?",
  "I said it.",
  "Musk!",
  "hi cutie",
  "Little\nexperiment",
  "Future d-3", // 75
  "Corny Poopy",
  "Below Ground",
  "Medical",
  "Merried Planet",
  "SpaceShip!", //80
  "Dreggon",
  "To the moon!",
  "SUMO",
  "Katana",
  "I am lost", // 85
  "Literal moon", 
  "Sweet spot", 
  "Spotverse", 
  "Not sun,\nYolk", 
  "Nova",  //90
  "It is all\negg",
  "IT-verse",
  "Present\nfor you",
];

class UpgradeStats {
  int base_egg_level = 1;
  BigInt base_egg_level_increase_cost = BigInt.from(20000);

  void setNewBaseEggLevel() {
    base_egg_level_increase_cost *= BigInt.from(4);
  }

  int spawn_time_decreaser_amount = 0;
  double spawn_time = 6;
  double spawn_time_counter = 6;
  BigInt spawn_time_decreaser_cost = BigInt.from(1000);
  void setNewSpawnTimerDecreaserCost(){
    spawn_time_decreaser_cost *= BigInt.from(2);
  }

  //iki tane doğma şansı kısmı
  int double_egg_increaser_amount = 0;
  BigInt double_egg_increaser_cost = BigInt.from(800000); // 2x every time
  void setNewDoubleEggCost(){
    double_egg_increaser_cost*=BigInt.from(2);
  }

  //wing at merge;
  int wing_at_merge_amount =0;
  BigInt wing_at_merge_cost = BigInt.from(250000); // 2x every time
  void setNewWingAtMergeCost(){
    wing_at_merge_cost*=BigInt.from(2);
  }

}
void resetDoubleEggUpgrd(UpgradeStats upgradeStats){
  upgradeStats.double_egg_increaser_amount = 0;
  upgradeStats.double_egg_increaser_cost = UpgradeStats().double_egg_increaser_cost; 
}
  void resetWingAtMergeUpgrd(UpgradeStats upgradeStats){
  upgradeStats.wing_at_merge_amount =0;
  upgradeStats.wing_at_merge_cost = UpgradeStats().wing_at_merge_cost; // 2x every time
}

class InGameStatsObject {

  int gameProgressionLevel = 0;

  void resetMergeLevel() {
    merge_level_current = 1;
    merge_level_required = 5;
    merge_level_merged = 0;
    merge_level_up_reward = 5;
    merge_level_percent = 0.0;
  }

  int merge_level_current = 1;
  int merge_level_required = 5;
  int merge_level_merged = 0;
  int merge_level_up_reward = 5;
  BigInt all_time_merge=BigInt.from(0);
  void increaseAllTimeMergeCount(){
    all_time_merge += BigInt.one;
  }

  bool willLevelUp() {
    if (merge_level_merged < merge_level_required) {
      return false;
    }
    return true;
  }

  void levelUp() {
    merge_level_current += 1;
    merge_level_merged = 0;
    merge_level_required =  3 * merge_level_current;
    goldenWing += merge_level_up_reward;
    merge_level_up_reward = 7 * merge_level_current;
  }

  double merge_level_percent = 0.0;
  void levelUpController() {
    merge_level_merged += 1;
    merge_level_percent =
        merge_level_merged.toDouble() / merge_level_required.toDouble();
    if (merge_level_percent > 1.0) {
      merge_level_percent = 1.0;
    }
    if (willLevelUp()) {
      levelUp();
      merge_level_percent = 0.0;
    }
  }

  BigInt totalMoney = BigInt.from(1);
  BigInt moneyPerSec = BigInt.from(1);
  int goldenWing = 0;
  BigInt allTimeMoney = BigInt.from(1);
  BigInt allAllTimeMoney = BigInt.from(1);
  int allTimeEggLevel = 0;
  int allAllTimeEggLevel = 0;

  int willGainAmountPrestigePoint = 0;
  int currentPrestigePoint = 0;

  
  
  int indexOfMultiplier = 0;
  
  void calculatePrestigePoint(InGameStatsObject ingame_stats_object) {
    indexOfMultiplier = 0;
    if(allTimeEggLevel < prestigeMileStones[0]){
      willGainAmountPrestigePoint = allTimeMoney.bitLength * 11;
      return;
    }

    for(int i = 0;i<prestigeMileStones.length;i++){
      if(ingame_stats_object.allTimeEggLevel>prestigeMileStones[i])
        indexOfMultiplier = i;
    }
    ingame_stats_object.willGainAmountPrestigePoint = allTimeMoney.bitLength *allTimeMoney.bitLength *allTimeMoney.bitLength *allTimeMoney.bitLength * prestigeMileStoneMultiplier[indexOfMultiplier];
  }



  void prestigeFunction(
      List<EggObject> eggIndexList, UpgradeStats upgradeStats) {
    currentPrestigePoint += willGainAmountPrestigePoint;
    totalMoney = BigInt.zero;
    moneyPerSec = BigInt.zero;
    allTimeMoney = BigInt.zero;
    willGainAmountPrestigePoint = 0;
    allTimeEggLevel = 1;
    resetUpgradeStats(upgradeStats);
    // resetMergeLevel();
    resetDoubleEggUpgrd(upgradeStats);
    resetWingAtMergeUpgrd(upgradeStats);

    for (int n = 0; n < 20; n++) {
    eggIndexList[n].level = 0;
    }
  }
}

List<String> ImageRoutes = [];

void buy_decrease_spawn_time(
    UpgradeStats upgrade_stats_object, InGameStatsObject ingame_stats_object) {
  ingame_stats_object.totalMoney -=
      upgrade_stats_object.spawn_time_decreaser_cost;
  upgrade_stats_object.spawn_time_counter -= 0.1;
  upgrade_stats_object.spawn_time -= 0.1;
  upgrade_stats_object.spawn_time_decreaser_cost *= BigInt.from(2);
  upgrade_stats_object.spawn_time_decreaser_amount += 1;
}

void resetUpgradeStats(UpgradeStats upgradeStats) {
  upgradeStats.base_egg_level = 1;
  upgradeStats.base_egg_level_increase_cost = BigInt.from(20000);

  upgradeStats.spawn_time_decreaser_amount = 0;
  upgradeStats.spawn_time = UpgradeStats().spawn_time;
  upgradeStats.spawn_time_counter = UpgradeStats().spawn_time_counter;
  upgradeStats.spawn_time_decreaser_cost = BigInt.from(1000);
}

bool isThereEmptySpace(List<EggObject> EggIndexList) {
  for (int n = 0; n < 20; n++) {
    //dolu mu boş mu layler ona göre
    if (EggIndexList[n].level == 0) {
      return true;
    }
  }

  return false;
}


bool willItHappen(int chance){

  int randomNumber = Random().nextInt(100)+1;
  if(chance>=randomNumber){
    return true;
  }
  return false;
}

void spawnOneEgg(UpgradeStats upgrade_stats_object, List<EggObject> EggIndexList) {
  for (int n = 0; n < 20; n++) {
    if (EggIndexList[n].level == 0) {
      EggIndexList[n].level += upgrade_stats_object.base_egg_level;
      break;
    }
  }
}


bool canIBuy(BigInt param,BigInt urun){
  if(param>=urun){
    return true;
  }
  return false;
}

void wingAtMerge (bool chance,InGameStatsObject inGameStatsObject){
  if(chance){
    inGameStatsObject.goldenWing++;
  }
}



bool gameGoldenEggController(int index,List<int> sayilar){
  for(int i = 0;i<sayilar.length;i++){
    if(index == sayilar[i]){
      return true;
    }
  }
  return false;
}


//TODO: altın yumurtalara bir ayar çek az kalıyor. - bunun artışını yumurtaların katsayısını yine bulunan oyunun ulaşılan max yumurta'ya oranına göre yapabilirisin ayrıca bir tane tanrı altın tavaların kazandırdığı miktarı arttırabilir. bir iken iki iki iken üç falan yapabilir tabi bunun için kaynak harcanacak.




List<int> prestigeMileStones = [];
List<int> prestigeMileStoneMultiplier = [2,4,8,16,48,96,200,500,360,1024,2048,4096];
void createPrestigeMileStones(){
  prestigeMileStones = [];
  
  for(int i = 34;i<gameEggCount;i+=6){
    prestigeMileStones.add(i);
  }

}


List<int> mileStoneEggs = [16,23,30,40];
void checkGameProgressionLevel(InGameStatsObject inGameStatsObject){
  for(int i=0;i<mileStoneEggs.length;i++){
    if(mileStoneEggs[i]<=inGameStatsObject.allAllTimeEggLevel){
      inGameStatsObject.gameProgressionLevel = i+1;
    }
  }
}




bool listedeVarMi(List<int> liste,aranan){
  for(int i=0;i<liste.length;i++){
    if(liste[i] == aranan) return true;
  }
  return false;
}









// at merge function
void atMergeFunction(InGameStatsObject ingame_stats_object,UpgradeStats upgrade_stats_object,List<EggObject> EggIndexList,int thisObjectIndex,int draggedObjectData){


  ingame_stats_object.increaseAllTimeMergeCount();
  ingame_stats_object.levelUpController();
  wingAtMerge(willItHappen(upgrade_stats_object.wing_at_merge_amount), ingame_stats_object);
  EggIndexList[thisObjectIndex].level++;
  EggIndexList[draggedObjectData].level = 0;

  ingame_stats_object.calculatePrestigePoint(ingame_stats_object);
}

int goldenPenKatsayisi = 1;



BigInt produceMoney(int index, List<EggObject> EggIndexList,InGameStatsObject ingame_stats_object,GodStats god_stats_object, Reklam reklam) {
  if(god_stats_object.priapus_active){
    BigInt sonuc = 
     BigInt.from(pow(10, 2*reklam.rewardedMoneyBoostActive)) *

      (BigInt.from(pow(10,god_stats_object.priapus_level))
      *(BigInt.from(3).pow(EggIndexList[index].level - 1) 
      +  BigInt.from(ingame_stats_object.currentPrestigePoint)
        *BigInt.from(3).pow(EggIndexList[index].level - 1)
        *BigInt.from(goldenPenKatsayisi)~/(BigInt.from(100))));
    return sonuc;
  }

  BigInt sonuc = 
    BigInt.from(pow(10,2*reklam.rewardedMoneyBoostActive))
    *((BigInt.from(3).pow(EggIndexList[index].level - 1)
     + BigInt.from(ingame_stats_object.currentPrestigePoint)
      *BigInt.from(3).pow(EggIndexList[index].level - 1)
      *BigInt.from(goldenPenKatsayisi)~/(BigInt.from(100))));

  return sonuc;
}

BigInt calculateMoneyPerSec(List<EggObject> EggIndexList,InGameStatsObject ingame_stats_object,GodStats god_stats_object,Reklam reklam) {
  BigInt result = BigInt.zero;
  for (int n = 0; n < 20; n++) {
    if (EggIndexList[n].level > 0) {
      result += produceMoney(n, EggIndexList, ingame_stats_object,god_stats_object,reklam);
    }
  }
  return result;
}