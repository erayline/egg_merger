import 'dart:math';




String bigIntToString(BigInt numara) {

  BigInt numaraHolder=numara;

  int basamak = 0;

  String numbersUnit = "";
  String result="none";
  for (int n = 0; n < 50; n++) {if (numara > BigInt.from(0)) {basamak++;}numara ~/= BigInt.from(10);}
  
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
  }else if(43<=basamak&&basamak<46){//buradan başlanacak
    numbersUnit="Td";
  }else if(46<=basamak&&basamak<49){
    numbersUnit="qd";
  }else if(49<=basamak&&basamak<52){
    numbersUnit="Qd";
  }else if(52<=basamak&&basamak<55){
    numbersUnit="sd";
  }else if(55<=basamak&&basamak<58){
    numbersUnit="Sd";
  }else if(58<=basamak&&basamak<61){
    numbersUnit="d";
  }else if(61<=basamak&&basamak<64){
    numbersUnit="Nd";
  }else if(64<=basamak&&basamak<67){
    numbersUnit="V";
  }else if(67<=basamak&&basamak<70){
    numbersUnit="Uv";
  }else if(70<=basamak&&basamak<73){
    numbersUnit="Dv";
  }else if(73<=basamak&&basamak<76){
    numbersUnit="qv";
  }else if(76<=basamak&&basamak<79){
    numbersUnit="Qv";
  }else if(79<=basamak&&basamak<82){
    numbersUnit="sv";
  }else if(82<=basamak&&basamak<85){
    numbersUnit="Sv";
  }else if(85<=basamak&&basamak<88){
    numbersUnit="Ov";
  }else if(88<=basamak&&basamak<91){
    numbersUnit="Nv";
  }else if(91<=basamak&&basamak<94){
    numbersUnit="Tg";
  }else if(94<=basamak&&basamak<97){
    numbersUnit="Ut";
  }else if(97<=basamak&&basamak<100){
    numbersUnit="Dt";
  }else if(100<=basamak&&basamak<58){
    numbersUnit="Tt";
  }
  else{
    numbersUnit="WTF";
  }
  
  
  if(basamak>=4){
    int birinciSayi = 0;

    BigInt kopyNumara = numara;
    for(int n=0;n<basamak-1;n++){
      kopyNumara~/=BigInt.from(pow(10,(1)));
    }
    birinciSayi = kopyNumara.toInt();
    kopyNumara=numara;




    int ikinciSayi=((numara%BigInt.from(10).pow(basamak-1)~/BigInt.from(10).pow(basamak-2))).toInt();
    int ucuncuSayi=((numara%BigInt.from(10).pow(basamak-2)~/BigInt.from(10).pow(basamak-3))).toInt();
    int dorduncuSayi=((numara%BigInt.from(10).pow(basamak-3)~/BigInt.from(10).pow(basamak-4))).toInt();


    if(basamak%3==1){
      result = "$birinciSayi.$ikinciSayi$ucuncuSayi$dorduncuSayi$numbersUnit";
    }else if(basamak%3==2){
      result = "$birinciSayi$ikinciSayi.$ucuncuSayi$dorduncuSayi$numbersUnit";
    }else if(basamak%3==0){
      result = "$birinciSayi$ikinciSayi$ucuncuSayi.$dorduncuSayi$numbersUnit";
    }
  }else{
    result="$numara";
  }
  
  return result;
}
