class GodStats{
  /*
  ilk tanrı - priapus
  - kazanç boostu verecek başlangıçta 
    1.level -> her 100 saniyede 5 saniyeliğine 100x kazanç boostu sağlayacak
    2.level -> her 75 saniyede 10 saniyeliğine 100x kazanç boostu sağlayacak
    3. level -> her 50 saniyede 15 saniyeliğine 100x kazanç boostu sağlayacak
  */
  int priapus_level = 0;
  int priapus_timer = 100;
  int priapus_active_time =5;
  bool priapus_active = false;

  void priapus_controller_1sec(){
    if(priapus_level>0){
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
    }
  }

  /*
  tanrı 2
  */



}