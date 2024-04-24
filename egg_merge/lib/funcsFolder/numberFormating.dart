import 'dart:math';

String bigIntToString() {
  int numara = 2114130043645000;
  int numaraHolder=numara;
  int basamak = 0;
  String numbersUnit = "";
  String result="none";
  for (int n = 0; n < 50; n++) {if (numara > 0) {basamak++;}numara ~/= 10;}
  numara=numaraHolder;
  
  if(0<=basamak&&basamak<4){
    numbersUnit="";
  }else if(4<=basamak&&basamak<7){
    numbersUnit="k";
  }else if(7<=basamak&&basamak<10){
    numbersUnit="M";
  }else if(10<=basamak&&basamak<13){
    numbersUnit="B";
  }else if(13<=basamak&&basamak<16){
    numbersUnit="T";
  }else if(16<=basamak&&basamak<19){
    numbersUnit="q";
  }else if(19<=basamak&&basamak<22){
    numbersUnit="Q";
  }else if(22<=basamak&&basamak<25){
    numbersUnit="s";
  }else if(25<=basamak&&basamak<28){
    numbersUnit="S";
  }else if(28<=basamak&&basamak<31){
    numbersUnit="o";
  }else if(31<=basamak&&basamak<34){
    numbersUnit="N";
  }else if(34<=basamak&&basamak<37){
    numbersUnit="d";
  }else if(37<=basamak&&basamak<40){
    numbersUnit="U";
  }else if(40<=basamak&&basamak<43){
    numbersUnit="D";
  }else{
    numbersUnit="WTF";
  }
  
  
  if(basamak>=4){
    int birinciSayi=numara~/pow(10,(basamak-1));
    int ikinciSayi=(numara%pow(10,(basamak-1)))~/pow(10,(basamak-2));
    int ucuncuSayi=(numara%pow(10,(basamak-2)))~/pow(10,(basamak-3));
    int dorduncuSayi=(numara%pow(10,(basamak-3)))~/pow(10,(basamak-4));
    if(basamak%3==1){
      result = "$birinciSayi.$ikinciSayi$ucuncuSayi$dorduncuSayi $numbersUnit";
    }else if(basamak%3==2){
      result = "$birinciSayi$ikinciSayi.$ucuncuSayi$dorduncuSayi $numbersUnit";
    }else if(basamak%3==0){
      result = "$birinciSayi$ikinciSayi$ucuncuSayi.$dorduncuSayi $numbersUnit";
    }
  }else{
    result="$numara";
  }
  
  return result;
}
