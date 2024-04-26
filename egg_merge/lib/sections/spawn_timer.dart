import 'dart:async';
import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
    return Consumer<EggObjectModel>( builder: (context, value, child) {
        return Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 255, 205, 41),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 17,
                    fillColor: Colors.transparent,
                    progressColor: Colors.blue,
                    percent: value.spawnerPercent,
                  ),
                  Text(
                      '${value.upgrade_stats_object.spawn_time_counter.toStringAsFixed(1)}/${value.upgrade_stats_object.spawn_time.toStringAsFixed(1)}'),
                  Image.asset(
                    ImageRoutes[value.upgrade_stats_object.base_egg_level - 1]
                        .toString(),
                    width: 50,
                  ),
                ],
              ),
              LinearPercentIndicator(
                animation: true,
                animateFromLastPercent: true,
                progressColor: Color.fromARGB(255, 20, 174, 92),
                width: 130,
                lineHeight: 30,
                percent: value.spawnerPercent,
              ), //buraya level
            ],
          ),
        );
      },
    );
  }
}
