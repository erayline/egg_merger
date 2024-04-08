import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List <int> idler=[
  0,0,2,0,
  0,0,0,0,
  0,0,0,0,
  0,0,0,0,
  0,0,0,0
];


class EggClass{
  int id = 0;
  EggClass(int id){
    this.id=id;
  }

  int produceMoney(){
    int result;
    result = 3^(this.id-1);
    return result;
  }

  Widget printEgg(){
    if (this.id == 0){
      return Container(
        width: 50,height: 50,
        color: Colors.black12,
      );
    }else{
      return Text(idler[0].toString());
    }
  }
}



EggClass ilk = new EggClass(2);

class EmptyBackground extends StatefulWidget {
  const EmptyBackground({super.key});

  @override
  State<EmptyBackground> createState() => _EmptyBackgroundState();
}

class _EmptyBackgroundState extends State<EmptyBackground> {
  @override
  Widget build(BuildContext context) {
    return ilk.printEgg();
  }
}