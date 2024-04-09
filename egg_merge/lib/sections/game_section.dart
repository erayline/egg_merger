import 'package:egg_merge/sections/eggClass.dart';
import 'package:egg_merge/sections/rootInfos.dart';
import 'package:flutter/material.dart';

class inGame extends StatefulWidget {
  const inGame({super.key});

  @override
  State<inGame> createState() => _inGameState();
}

class _inGameState extends State<inGame> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color.fromARGB(255, 250, 212, 177),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            gameRow_1(),
            gameRow_2(),
            gameRow_3(),
            gameRow_4(),
            gameRow_5(),
          ],
        ),
      )
    );
  }
}






//GAME LAYOUT BELOW


class gameRow_1 extends StatefulWidget {
  const gameRow_1({super.key});

  @override
  State<gameRow_1> createState() => _gameRow_1State();
}

class _gameRow_1State extends State<gameRow_1> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(deneme==1)
                  egg_19.printEgg()
                else 
                  egg_10.printEgg(),
                if(deneme==1)
                  egg_18.printEgg()
                else 
                  egg_18.printEgg(),
                if(deneme==1)
                  egg_17.printEgg()
                else 
                  egg_17.printEgg(),
                if(deneme==1)
                  egg_16.printEgg()
                else 
                  egg_16.printEgg(),
              ],
            );
  }
}


class gameRow_2 extends StatefulWidget {
  const gameRow_2({super.key});

  @override
  State<gameRow_2> createState() => _gameRow_2State();
}

class _gameRow_2State extends State<gameRow_2> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(deneme==1)
                  egg_15.printEgg()
                else 
                  egg_15.printEgg(),
                if(deneme==1)
                  egg_14.printEgg()
                else 
                  egg_14.printEgg(),
                if(deneme==1)
                  egg_13.printEgg()
                else 
                  egg_13.printEgg(),
                if(deneme==1)
                  egg_12.printEgg()
                else 
                  egg_12.printEgg(),
              ],
            );
  }
}

class gameRow_3 extends StatefulWidget {
  const gameRow_3({super.key});

  @override
  State<gameRow_3> createState() => _gameRow_3State();
}

class _gameRow_3State extends State<gameRow_3> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(deneme==1)
                  egg_11.printEgg()
                else 
                  egg_11.printEgg(),
                if(deneme==1)
                  egg_10.printEgg()
                else 
                  egg_10.printEgg(),
                if(deneme==1)
                  egg_9.printEgg()
                else 
                  egg_9.printEgg(),
                if(deneme==1)
                  egg_8.printEgg()
                else 
                  egg_8.printEgg(),
              ],
            );
  }
}

class gameRow_4 extends StatefulWidget {
  const gameRow_4({super.key});

  @override
  State<gameRow_4> createState() => _gameRow_4State();
}

class _gameRow_4State extends State<gameRow_4> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(deneme==1)
                  egg_7.printEgg()
                else 
                  egg_7.printEgg(),
                if(deneme==1)
                  egg_6.printEgg()
                else 
                  egg_6.printEgg(),
                if(deneme==1)
                  egg_5.printEgg()
                else 
                  egg_5.printEgg(),
                if(deneme==1)
                  egg_4.printEgg()
                else 
                  egg_4.printEgg(),
              ],
            );
  }
}

class gameRow_5 extends StatefulWidget {
  const gameRow_5({super.key});

  @override
  State<gameRow_5> createState() => _gameRow_5State();
}

class _gameRow_5State extends State<gameRow_5> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(deneme==1)
                  egg_3.printEgg()
                else 
                  egg_3.printEgg(),
                if(deneme==1)
                  egg_2.printEgg()
                else 
                  egg_2.printEgg(),
                if(deneme==1)
                  egg_1.printEgg()
                else 
                  egg_1.printEgg(),
                if(deneme==1)
                  egg_0.printEgg()
                else 
                  egg_0.printEgg(),
              ],
            );
  }
}