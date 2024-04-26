import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class upperBar extends StatefulWidget {
  const upperBar({super.key});

  @override
  State<upperBar> createState() => _upperBarState();
}

class _upperBarState extends State<upperBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 223, 151, 109),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        upperMoneyBar(),
        upperWingBar(),
        adBox()
      ],),
    );
  }
}






class upperMoneyBar extends StatefulWidget {
  const upperMoneyBar({super.key});

  @override
  State<upperMoneyBar> createState() => upperMoneyBarState();
}

class upperMoneyBarState extends State<upperMoneyBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 40,width: MediaQuery.of(context).size.width*4/12,
        color: Color.fromARGB(255, 20, 174, 92),
        child: Row(children: <Widget>[
          SizedBox(width: 6,),
          Image.asset('ourAssets/images/money.png',width: 30,),
          Consumer<EggObjectModel>(builder:(context, value, child) {
            return Expanded(child: Column(
              children: [
                Center(child: Text(bigIntToString(value.ingame_stats_object.totalMoney))),
                Center(child: Text(bigIntToString((value.calculateMoneyPerSec()))+"/s")),
              ],
            ));
          },),
          SizedBox(width: 30,),
        ],),
      ),
    );
  }
}


class upperWingBar extends StatefulWidget {
  const upperWingBar({super.key});

  @override
  State<upperWingBar> createState() => _upperWingBarState();
}

class _upperWingBarState extends State<upperWingBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>( builder: (context, value, child) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 40,width: MediaQuery.of(context).size.width*4/12,
        color: Color.fromARGB(255, 20, 174, 92),
        child: Row(children: <Widget>[
          SizedBox(width: 6,),
          Image.asset('ourAssets/images/chicken-wings.png',width: 30,),
          Expanded(child: Center(child: Text("${value.ingame_stats_object.goldenWing}"))),
          SizedBox(width: 30,),
        ],),
      ),
    );
    },);
  }
}

class adBox extends StatefulWidget {
  const adBox({super.key});

  @override
  State<adBox> createState() => _adBoxState();
}

class _adBoxState extends State<adBox> {
  @override
  
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>( builder: (context, value, child) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 40,width: 40,
        color: Color.fromARGB(255, 20, 174, 92),
        child: Center(child: Text(value.ingame_stats_object.merge_level_current.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0,color: Colors.amber,)),
      ),
    ));
    },);
  }
}