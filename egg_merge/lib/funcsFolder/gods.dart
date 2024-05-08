class GodStats{
  /*
  ilk tanrı - priapus
  - kazanç boostu verecek başlangıçta 
    1.level -> her 100 saniyede 5 saniyeliğine 100x kazanç boostu sağlayacak
    2.level -> her 75 saniyede 10 saniyeliğine 100x kazanç boostu sağlayacak
    3. level -> her 50 saniyede 15 saniyeliğine 100x kazanç boostu sağlayacak
  */
  int priapus_level = 0;
  int priapus_feed_level = 1;
  int priapus_timer = 100;
  int priapus_active_time =5;
  bool priapus_active = false;
  int priapus_cost = 10; // golden wing
  void priapus_cost_increase(){
    priapus_cost = priapus_feed_level*10;
  }
  void priapus_level_controller(){
    if(priapus_feed_level>= 100){
      priapus_level++;
      priapus_timer = 75;
      priapus_active_time = 10;
    }
  }
  void priapus_controller_1sec(){
    if(priapus_level==1){
      priapus_timer--;
      if(priapus_timer<=0){
        priapus_active = true;
        priapus_active_time--;
        print('active');
      }
      if(priapus_active_time<0){
        priapus_active_time = 5;
        priapus_timer = 10;
        priapus_active = false;
      }
    }else if(priapus_level==2){
      priapus_timer--;
      if(priapus_timer<=0){
        priapus_active = true;
        priapus_active_time--;
        print('active');
      }
      if(priapus_active_time<0){
        priapus_active_time = 10;
        priapus_timer = 75;
        priapus_active = false;
      }
    }
  }

  /*
  tanrı 2
  */



}