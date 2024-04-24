import 'dart:async';
import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
          Consumer<EggObjectModel>(builder: (context, value, child) {
                return LinearPercentIndicator(
                  // animation: true,
                  // animateFromLastPercent: true,
                  progressColor: Color.fromARGB(255, 20, 174, 92),
                  width: 320,
                  lineHeight: 30,
                  percent: value.spawnerPercent,
                );
              },
            ),

          const SizedBox(
            width: 6,
          ),
          Consumer<EggObjectModel>(builder: (context, value, child) {
          return Image.asset(
              ImageRoutes[value.upgrade_stats_object.base_egg_level-1].toString(),
              width: 50,
            );}),
          const SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }
}
