
import 'dart:math';

import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';



class GodUpgradeTileWidget extends StatefulWidget {
  final String god_image;
  final String god_name;
  final String god_sub_name;
  final Color god_color;
  final int god_level;
  final int god_feed_level;
  final int god_cooldown;
  final int god_cost;
  final int golden_wing;
  final Function()? feed_unlock;


  const GodUpgradeTileWidget({super.key, required this.god_image, required this.god_name, required this.god_sub_name, required this.god_color, required this.god_level, required this.god_feed_level, required this.god_cooldown, required this.god_cost, required this.golden_wing, required this.feed_unlock});

  @override
  State<GodUpgradeTileWidget> createState() => _GodUpgradeTileWidgetState();
}

class _GodUpgradeTileWidgetState extends State<GodUpgradeTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Image.asset(
                    widget.god_image,
                    width: 100,
                    height: 100,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.god_name,
                      style: TextStyle(
                          fontSize: 23,
                          color: widget.god_color,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.god_sub_name,
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Level ${widget.god_level}',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LinearPercentIndicator(
                  animation: true,
                  animateFromLastPercent: true,
                  center: ((value.god_stats_object.priapus_level != 3 ? Text(
                      "${widget.god_feed_level}/${100}") : Text('Enjoy me'))),
                  progressColor: widget.god_color,
                  width: 150,
                  lineHeight: 30,
                  percent: (widget.god_level !=3 ? widget.god_feed_level / 100 : 1),
                ),
                Container(
                  width: 110,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Boost: ',
                            style: TextStyle(fontSize: 11),
                          ),
                          Text(
                            '${pow(10,value.god_stats_object.priapus_level)}x',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 156, 7)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Duration: ', style: TextStyle(fontSize: 11)),
                          Text('${value.god_stats_object.priapus_active_time}s',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Cooldown: ', style: TextStyle(fontSize: 11)),
                          Text('${(0<widget.god_cooldown?widget.god_cooldown:0)}s',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed:widget.feed_unlock,

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          (widget.god_cost <
                                  widget.golden_wing
                              ? Color.fromARGB(255, 115, 203, 0)
                              : Colors.red)),
                      foregroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 0, 0, 0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (value.god_stats_object.priapus_level<1 ? Text(
                        ('Unlock -> ${widget.god_cost}  '),
                      ) : (value.god_stats_object.priapus_level<3 ? Text(
                        ('Feed ->  ${widget.god_cost}  '),
                      ): Text('MAXED'))),
                      (value.god_stats_object.priapus_level<3 ?Image.asset(
                        "ourAssets/images/chicken-wings.png",
                        width: 30,
                      ) : Text(''))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
