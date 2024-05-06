import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class inGame extends StatefulWidget {
  const inGame({super.key});

  @override
  State<inGame> createState() => _inGameState();
}

class _inGameState extends State<inGame> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: ((context, value, child){
      return Expanded(
        child: Container(
          color: Color.fromARGB(255, 250, 226, 177),
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
  }));
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
    return Consumer<EggObjectModel>(
      builder: (BuildContext context, value, child) { 

        return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  value.printDragTargetEggWidget(19),
                  value.printDragTargetEggWidget(18),
                  value.printDragTargetEggWidget(17),
                  value.printDragTargetEggWidget(16),
                ],
              );
       },
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
    return Consumer<EggObjectModel>(
      builder: (BuildContext context, value, Widget? child) { 
        return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  value.printDragTargetEggWidget(15),
                  value.printDragTargetEggWidget(14),
                  value.printDragTargetEggWidget(13),
                  value.printDragTargetEggWidget(12),
                ],
              );
       },
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
    return Consumer<EggObjectModel>(
      builder: (BuildContext context, value, Widget? child) { 
        return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  value.printDragTargetEggWidget(11),
                  value.printDragTargetEggWidget(10),
                  value.printDragTargetEggWidget(9),
                  value.printDragTargetEggWidget(8),
                ],
              );
            },
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
    return Consumer<EggObjectModel>(
      builder: (BuildContext context, value, Widget? child) { 
        return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  value.printDragTargetEggWidget(7),
                  value.printDragTargetEggWidget(6),
                  value.printDragTargetEggWidget(5),
                  value.printDragTargetEggWidget(4),
                ],
              );
       },
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
    return Consumer<EggObjectModel>(
      builder: (BuildContext context, value, Widget? child) { 
        return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  value.printDragTargetEggWidget(3),
                  value.printDragTargetEggWidget(2),
                  value.printDragTargetEggWidget(1),
                  value.printDragTargetEggWidget(0),
                ],
              );
       },
    );
  }
}