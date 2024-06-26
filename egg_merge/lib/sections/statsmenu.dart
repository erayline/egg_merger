import 'package:egg_merge/components/stats_line.dart';
import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsMenu extends StatefulWidget {
  const StatsMenu({super.key});

  @override
  State<StatsMenu> createState() => _StatsMenuState();
}

class _StatsMenuState extends State<StatsMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            width: 1000,
            height: 500,
            decoration: BoxDecoration(
              border: Border.all(width: 3),
              color: Color.fromARGB(255, 57, 119, 59),
            ),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Color.fromARGB(255, 8, 51, 17),
                    toolbarHeight: 0.0,
                    automaticallyImplyLeading: false,
                    bottom: const TabBar(
                      labelColor: Color.fromARGB(255, 252, 198, 0),
                      dividerHeight: 0.0,
                      unselectedLabelColor: Colors.white38,
                      indicatorColor: Color.fromARGB(255, 252, 198, 0),
                      tabs: [
                        Tab(
                            icon: Text(
                          'Eggs',
                        )),
                        Tab(
                            icon: Text(
                          'Stats',
                        ))
                      ],
                    )),
                body: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 65, 150, 68),
                  ),
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,10,0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // 10 sütun
                              mainAxisSpacing: 10.0, // Satırlar arası boşluk
                              crossAxisSpacing: 10.0, // Sütunlar arası boşluk
                            ),
                            itemCount: gameEggCount,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: IconButton(
                                onPressed: () {
                                  if (value
                                          .ingame_stats_object.allTimeEggLevel >
                                      index) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 44, 4, 48),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                            ),
                                            width: 100,
                                            height: 200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      ImageRoutes[index]
                                                          .toString(),
                                                      width: 120,
                                                    ),
                                                    Text(
                                                      (index + 1).toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      '${eggNames[index]}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                    ),
                                                    Text(
                                                      'Base: ${bigIntToString(BigInt.from(3).pow(index))}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      'Current: ${bigIntToString(BigInt.from(3).pow(index) + BigInt.from(value.ingame_stats_object.currentPrestigePoint) * BigInt.from(3).pow(index) * BigInt.from(goldenPenKatsayisi) ~/ (BigInt.from(100)))}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                icon: Stack(children: [
                                  Image.asset(ImageRoutes[index].toString(),
                                      color: (index <
                                              value.ingame_stats_object
                                                  .allTimeEggLevel)
                                          ? null
                                          : (((index >=
                                                      value.ingame_stats_object
                                                          .allAllTimeEggLevel &&
                                                  gameGoldenEggController(
                                                      index, mileStoneEggs)))
                                              ? Colors.amber
                                              : Colors.black)),
                                  (listedeVarMi(prestigeMileStones, index)
                                      ? (prestigeMileStones[value.ingame_stats_object
                                                  .indexOfMultiplier] >=
                                              index
                                          ? Text(
                                              '${prestigeMileStoneMultiplier[prestigeMileStones.indexOf(index)]}x',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text('?',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold)))
                                      : Text(''))
                                ]),
                                highlightColor: Colors.transparent,
                              ));
                            }),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            StatsLineWidget(
                                color: Color.fromARGB(255, 14, 82, 52),
                                infoName: "All Time Money",
                                infoItself: bigIntToString(
                                    value.ingame_stats_object.allAllTimeMoney)),
                            StatsLineWidget(
                                color: Color.fromARGB(255, 6, 36, 79),
                                infoName: "All the Merge you did",
                                infoItself: bigIntToString(
                                    value.ingame_stats_object.all_time_merge)),
                            StatsLineWidget(
                                color: Color.fromARGB(255, 129, 58, 14),
                                infoName: "Biggest Egg level",
                                infoItself: value
                                    .ingame_stats_object.allAllTimeEggLevel
                                    .toString()),
                            StatsLineWidget(
                                color: Color.fromARGB(255, 0, 0, 0),
                                infoName: "god chicken count",
                                infoItself: (value.god_stats_object.priapus_level>0?"1":"0")),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      );
    });
  }
}
