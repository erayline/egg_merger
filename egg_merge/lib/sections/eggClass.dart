import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class EggClass{
  int id = 1;
  int baseEarning=1;

  EggClass(int id){
    this.id=id;
  }

  

  Widget printEgg(){
    return Container(
      child: Text(this.id.toString()),
    );
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