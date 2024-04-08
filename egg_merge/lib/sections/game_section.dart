import 'package:egg_merge/sections/eggClass.dart';
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
            gameRow(),
            gameRow(),
            gameRow(),
            gameRow(),
            gameRow(),
          ],
        ),
      )
    );
  }
}

class gameRow extends StatefulWidget {
  const gameRow({super.key});

  @override
  State<gameRow> createState() => _gameRowState();
}

class _gameRowState extends State<gameRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                EmptyBackground(),
                EmptyBackground(),
                EmptyBackground(),
                EmptyBackground(),
              ],
            );
  }
}