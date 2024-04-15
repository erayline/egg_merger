import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UygulamaModeli extends ChangeNotifier {
  int counter = 10;
}

class spawnTimer extends StatefulWidget {
  const spawnTimer({super.key});

  @override
  State<spawnTimer> createState() => _spawnTimerState();
}

class _spawnTimerState extends State<spawnTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 255, 205, 41),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 56,
          ),
          Expanded(
            child: Consumer<UygulamaModeli>(
              builder: (context, value, child) {
                return Center(child: Text(value.counter.toString()));
              },
            ),
          ),
          Image.asset(
            'ourAssets/images/animal.png',
            width: 50,
          ),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }
}
