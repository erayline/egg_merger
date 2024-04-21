import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'rootInfos.dart';

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
      padding: const EdgeInsets.fromLTRB(6, 7, 0, 7),
      child: Container(
        height: 40,width: 180,
        color: Color.fromARGB(255, 20, 174, 92),
        child: Row(children: <Widget>[
          SizedBox(width: 6,),
          Image.asset('ourAssets/images/money.png',width: 30,),
          Consumer<EggObjectModel>(builder:(context, value, child) {
            return Expanded(child: Column(
              children: [
                Center(child: Text(value.totalMoney.toString())),
                Center(child: Text(value.calculateMoneyPerSec().toString()+"/s")),
              ],
            ));
          },),
          SizedBox(width: 36,),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 7, 0, 7),
      child: Container(
        height: 40,width: 140,
        color: Color.fromARGB(255, 20, 174, 92),
        child: Row(children: <Widget>[
          SizedBox(width: 6,),
          Image.asset('ourAssets/images/chicken-wings.png',width: 30,),
          Expanded(child: Center(child: Text(wingA.toString()))),
          SizedBox(width: 36,),
        ],),
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 7, 7, 7),
      child: Container(
        height: 40,width: 40,
        color: Color.fromARGB(255, 20, 174, 92),
      ),
    );
  }
}