class GodStats{
  /*
  ilk tanrı - priapus
  - kazanç boostu verecek başlangıçta 
    1.level -> her 100 saniyede 5 saniyeliğine 100x kazanç boostu sağlayacak
    2.level -> her 75 saniyede 10 saniyeliğine 100x kazanç boostu sağlayacak
    3. level -> her 50 saniyede 15 saniyeliğine 100x kazanç boostu sağlayacak
  */
  int priapus_level = 0;
  int priapus_unlock_cost = 5000;
  int priapus_feed_level = 1;
  int priapus_timer = 100;
  int priapus_active_time =5;
  bool priapus_active = false;
  int priapus_cost = 5000; // golden wing
  void priapus_cost_increase(){
    priapus_cost = priapus_feed_level*3 + (priapus_level-1)*200;
  }
  void priapus_level_controller(){
    
    priapus_feed_level++;
    priapus_cost_increase();

    if(priapus_feed_level>= 100){
      priapus_level++;
      priapus_feed_level = 0;
      priapus_timer = 125-priapus_level*25;
      priapus_active_time = 5*priapus_level;
    }
  }
  void priapus_controller_1sec(){
    if(priapus_level>0){
      priapus_timer--;
      if(priapus_timer<=0){
        priapus_active = true;
        priapus_active_time--;
        print('active');
      }
      if(priapus_active_time<0){
        priapus_active_time = 5*priapus_level;
        priapus_timer = 100 - (25*(priapus_level-1));
        priapus_active = false;
      }
    }
  }

  /*
  tanrı 2
  Chronos zaman indirimi sağlıyor
    1.level -> her 200 saniyede 10 saniyeliğine .4 kazanç boostu sağlayacak
    2.level -> her 150 saniyede 20 saniyeliğine .9 kazanç boostu sağlayacak
    3. level -> her 100 saniyede 30 saniyeliğine .14 kazanç boostu sağlayacak
  */
  
  int chronos_level = 0;
  int chronos_unlock_cost = 5000;
  int chronos_cost = 10; // gold
  int chronos_feed_level = 1;
  int chronos_timer = 100;
  int chronos_active_time =5;
  bool chronos_active = false;



}