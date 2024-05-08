import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
    return ListView(
      children: [GodUpgradeTile()],
    );
  }
}

class GodUpgradeTile extends StatefulWidget {
  const GodUpgradeTile({super.key});

  @override
  State<GodUpgradeTile> createState() => _GodUpgradeTileState();
}

class _GodUpgradeTileState extends State<GodUpgradeTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  "ourAssets/images/gods/priapus.png",
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    Text(
                      'Priapus',
                      style: TextStyle(fontSize: 23),
                    ),
                    Text(
                      'God of Wealth',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      'Level 1',
                      style: TextStyle(fontSize: 15),
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
                  center: Text("${value.god_stats_object.priapus_feed_level}/${100}"),
                  progressColor: Color.fromARGB(255, 20, 174, 92),
                  width: 150,
                  lineHeight: 30,
                  percent: value.god_stats_object.priapus_feed_level / 100,
                ),
                Container(
                  width: 110,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Boost: '),
                          Text(
                            '10x',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Duration: '),
                          Text('5s',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Cooldown: '),
                          Text('100s',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,30,0,0),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if(value.ingame_stats_object.goldenWing>=value.god_stats_object.priapus_cost){
                      value.god_stats_object.priapus_cost_increase();
                      value.ingame_stats_object.goldenWing-=value.god_stats_object.priapus_cost;
                      value.god_stats_object.priapus_feed_level++;
                    }
                    //burada artış gerçekleşecek koşullardan sonra
                    print('Upgrade!');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all((value.god_stats_object.priapus_cost<value.ingame_stats_object.goldenWing ?Color.fromARGB(255, 115, 203, 0) : Colors.red)),
                      foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        ('Upgrade  ->  ${value.god_stats_object.priapus_cost}'),
                      ),
                      Image.asset("ourAssets/images/chicken-wings.png",width: 30,)
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
