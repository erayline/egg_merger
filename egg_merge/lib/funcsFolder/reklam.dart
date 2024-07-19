class Reklam{

  int rewardedMoneyBoostActive = 0;
  int rewardedMoneyBoostTimer = 0;

  void rewardedMoneyBoostStart(){
    rewardedMoneyBoostTimer = 60;
    rewardedMoneyBoostActive = 1;
  }

  void rewardedMoneyBoostController(){
    if (rewardedMoneyBoostActive == 1){
      rewardedMoneyBoostTimer--;
      print('$rewardedMoneyBoostTimer');
      if( rewardedMoneyBoostTimer <1){
          rewardedMoneyBoostActive = 0;
      }
    }
  }



}