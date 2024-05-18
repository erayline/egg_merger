import 'package:egg_merge/components/god_tile.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrestigeMenu extends StatefulWidget {
  const PrestigeMenu({super.key});

  @override
  State<PrestigeMenu> createState() => _PrestigeMenuState();
}

class _PrestigeMenuState extends State<PrestigeMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Dialog(
        backgroundColor: Color.fromARGB(255, 1, 1, 0),
        child: Container(
          height: 500,
          width: 1000,
          decoration: BoxDecoration(
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(1.0),
              color: Color.fromARGB(255, 219, 183, 122)),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 0.0,
                  backgroundColor: Color.fromARGB(255, 166, 128, 62),
                  bottom: TabBar(
                    labelColor: Color.fromARGB(255, 255, 255, 20),
                    indicatorColor: Colors.white,
                    dividerHeight: 0,
                    tabs: [
                      Tab(
                        icon: Text('PRESTIGE'),
                      ),
                      Tab(icon: Text('GODS'))
                    ],
                  )),
              body: Container(
                color: Color.fromARGB(255, 219, 183, 122),
                child: TabBarView(
                  children: [PrestigeControlPage(), GodControlPage()],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PrestigeControlPage extends StatefulWidget {
  const PrestigeControlPage({super.key});

  @override
  State<PrestigeControlPage> createState() => PrestigeControlPageState();
}

class PrestigeControlPageState extends State<PrestigeControlPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'PRESTIGE',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
          ),
          Container(
              width: 180,
              height: 80,
              decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.circular(4.0),
                  color: Color.fromARGB(255, 255, 230, 0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('You have:'),
                  Text(
                    '${value.ingame_stats_object.currentPrestigePoint} golden pen',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              )),
          Container(
            width: 180,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(width: 3),
                borderRadius: BorderRadius.circular(4.0),
                color: Color.fromARGB(255, 127, 127, 127)),
            child: Center(
                child: Text(
              '%${value.ingame_stats_object.currentPrestigePoint} boost',
              style: TextStyle(fontWeight: FontWeight.w700),
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 130,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(4.0),
                color: Color.fromARGB(255, 255, 236, 33)),
            child: Center(
              child: Text(
                '+${value.ingame_stats_object.willGainAmountPrestigePoint}',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (value.ingame_stats_object.willGainAmountPrestigePoint > 0) {
                  value.ingame_stats_object.prestigeFunction(
                      value.EggIndexList, value.upgrade_stats_object);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 168, 255, 139)),
                  foregroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 0, 0, 0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  )),
              child: Text('prestige'))
        ],
      );
    });
  }
}

class GodControlPage extends StatefulWidget {
  const GodControlPage({super.key});

  @override
  State<GodControlPage> createState() => _GodControlPageState();
}

class _GodControlPageState extends State<GodControlPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return ListView(
        children: [
          (value.ingame_stats_object.gameProgressionLevel > 1
              ? GodUpgradeTileWidget(
                  god_image: "ourAssets/images/gods/priapus.png",
                  god_name: "Priapus",
                  god_sub_name: "God Of Wealth",
                  god_color: Colors.purple,
                  god_level: value.god_stats_object.priapus_level,
                  god_feed_level: value.god_stats_object.priapus_feed_level,
                  god_cooldown: value.god_stats_object.priapus_timer,
                  god_cost: value.god_stats_object.priapus_cost,
                  golden_wing: value.ingame_stats_object.goldenWing,
                  feed_unlock: () {
                    //kilidi açılmamışsa
                    if (value.god_stats_object.priapus_level < 1) {
                      if (value.ingame_stats_object.goldenWing >=
                          value.god_stats_object.priapus_unlock_cost) {
                        value.god_stats_object.priapus_level++;
                        value.ingame_stats_object.goldenWing -=
                            value.god_stats_object.priapus_unlock_cost;
                        return;
                      }
                      return;
                    }
                    //kilidi açılmışsa
                    if (value.ingame_stats_object.goldenWing >=
                            value.god_stats_object.priapus_cost &&
                        value.god_stats_object.priapus_level < 3) {
                      value.god_stats_object.priapus_level_controller();
                      value.ingame_stats_object.goldenWing -=
                          value.god_stats_object.priapus_cost;
                    }
                  },
                  god_active_time: value.god_stats_object.priapus_active_time,
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Center(
                      child: Text(
                    'TO UNLOCK GODS\nUNLOCK EGGS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  )),
                )),
          (value.ingame_stats_object.gameProgressionLevel > 2
              ? GodUpgradeTileWidget(
                  god_image: "ourAssets/images/gods/chronos.png",
                  god_name: "Chronos",
                  god_sub_name: "(currently\nnot functional)",
                  god_color: Color.fromARGB(255, 255, 117, 19),
                  god_level: value.god_stats_object.chronos_level,
                  god_feed_level: value.god_stats_object.chronos_feed_level,
                  god_cooldown: value.god_stats_object.chronos_timer,
                  god_cost: value.god_stats_object.chronos_cost,
                  golden_wing: value.ingame_stats_object.goldenWing,
                  feed_unlock: () {},
                  god_active_time: value.god_stats_object.chronos_active_time,
                )
              : Center(
                  child: Text(
                  'To unlock god\nunlock eggs',
                  style: TextStyle(fontSize: 19, color: Colors.black),
                ))),
          SizedBox(
            height: 130,
          )
        ],
      );
    });
  }
}
