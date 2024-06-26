import 'package:egg_merge/components/upgrade_tile.dart';
import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpgradeMenu extends StatefulWidget {
  const UpgradeMenu({super.key});

  @override
  State<UpgradeMenu> createState() => _UpgradeMenuState();
}

class _UpgradeMenuState extends State<UpgradeMenu> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          width: 1000,
          height: 500,
          decoration: BoxDecoration(
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(5.0),
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //liste
            children: <Widget>[
              IncreaseBaseEggWidget(),
              DecreaseSpawnTimeWidget(),
              ChanceToSpawn2EggWidget(),
              ChanceToEarnWingWidget(),
              ExpandEggStoreHouseWidget(),
              MoreOfflineEarningRateWidget()
            ],
          )),
    );
  }
}

class UpgradeMenuButton extends StatefulWidget {
  final String title;
  const UpgradeMenuButton({Key? key, required this.title}) : super(key: key);
  @override
  State<UpgradeMenuButton> createState() => _UpgradeMenuButtonState();
}

class _UpgradeMenuButtonState extends State<UpgradeMenuButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            print('tebrikler');
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              )),
          child: Text("${widget.title}")),
    );
  }
}

class IncreaseBaseEggWidget extends StatefulWidget {
  const IncreaseBaseEggWidget({super.key});

  @override
  State<IncreaseBaseEggWidget> createState() => _IncreaseBaseEggWidgetState();
}

class _IncreaseBaseEggWidgetState extends State<IncreaseBaseEggWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 3),
            color: (value.ingame_stats_object.totalMoney >=
                    value.upgrade_stats_object.base_egg_level_increase_cost
                ? Color.fromARGB(255, 128, 255, 119)
                : Color.fromARGB(162, 244, 67, 54))),
        height: 70,
        child: Row(
          //içerik soldan sağa
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // ikon ve ilerleme
              width: 90,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "ourAssets/images/upgradeMenuIcons/egg.png",
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    '${value.upgrade_stats_object.base_egg_level}/$gameEggCount',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Text(
              '+ Base\nEgg',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 115,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    if (canIBuy(
                        value.ingame_stats_object.totalMoney,
                        value.upgrade_stats_object
                            .base_egg_level_increase_cost)) {
                      value.increaseBaseEgg(value.upgrade_stats_object,
                          value.ingame_stats_object);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                  child: Text((gameEggCount <=
                          value.upgrade_stats_object.base_egg_level
                      ? "MAXED"
                      : "${bigIntToString(value.upgrade_stats_object.base_egg_level_increase_cost)} \$"))),
            ),
          ],
        ),
      );
    });
  }
}

class DecreaseSpawnTimeWidget extends StatefulWidget {
  const DecreaseSpawnTimeWidget({super.key});

  @override
  State<DecreaseSpawnTimeWidget> createState() =>
      _DecreaseSpawnTimeWidgetState();
}

class _DecreaseSpawnTimeWidgetState extends State<DecreaseSpawnTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 3),
            color: (value.ingame_stats_object.totalMoney >=
                    value.upgrade_stats_object.spawn_time_decreaser_cost
                ? Color.fromARGB(255, 128, 255, 119)
                : Color.fromARGB(162, 244, 67, 54))),
        height: 70,
        child: Row(
          //içerik soldan sağa
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // ikon ve ilerleme
              width: 90,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "ourAssets/images/upgradeMenuIcons/chicken.png",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${value.upgrade_stats_object.spawn_time_decreaser_amount}/40",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Text(
              '- Spawn\nTime',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 115,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (canIBuy(value.ingame_stats_object.totalMoney,
                      value.upgrade_stats_object.spawn_time_decreaser_cost)) {
                    if (value.upgrade_stats_object.spawn_time_decreaser_amount <
                        40) {
                      buy_decrease_spawn_time(value.upgrade_stats_object,
                          value.ingame_stats_object);
                    }
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    )),
                child: Text((40 <=
                        value.upgrade_stats_object.spawn_time_decreaser_amount
                    ? "MAXED"
                    : "${bigIntToString(value.upgrade_stats_object.spawn_time_decreaser_cost)} \$")),
              ),
            )
          ],
        ),
      );
    });
  }
}

class ChanceToSpawn2EggWidget extends StatefulWidget {

  const ChanceToSpawn2EggWidget({super.key});


  @override
  State<ChanceToSpawn2EggWidget> createState() =>
      _ChanceToSpawn2EggWidgetState();
}

class _ChanceToSpawn2EggWidgetState extends State<ChanceToSpawn2EggWidget> {


  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(
      builder: (context, value, child) {
        return UpgradeTileWidget(
            upgradeImageRoute: "ourAssets/images/upgradeMenuIcons/eggs.png",
            upgradeLimit: 50,
            upgradedAmount:
                value.upgrade_stats_object.double_egg_increaser_amount,
            upgradeName: "%spawn\n2 egg",
            upgradeFunction: (){
              if (canIBuy(value.ingame_stats_object.totalMoney, value.upgrade_stats_object.double_egg_increaser_cost)) {
                if (value.upgrade_stats_object.double_egg_increaser_amount < 50) {
                  value.ingame_stats_object.totalMoney -= value.upgrade_stats_object.double_egg_increaser_cost;
                  value.upgrade_stats_object.double_egg_increaser_amount++;
                  value.upgrade_stats_object.setNewDoubleEggCost();
                }
              }
            },
            upgradeCost: value.upgrade_stats_object.double_egg_increaser_cost);
      },
    );
  }
}

// class ChanceToSpawn2EggWidget extends StatefulWidget {
//   const ChanceToSpawn2EggWidget({super.key});

//   @override
//   State<ChanceToSpawn2EggWidget> createState() =>
//       _ChanceToSpawn2EggWidgetState();
// }

// class _ChanceToSpawn2EggWidgetState extends State<ChanceToSpawn2EggWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<EggObjectModel>(builder: (context, value, child) {

//     return Container(
//       decoration: BoxDecoration(border: Border.all(width:3),color: (value.ingame_stats_object.totalMoney>=value.upgrade_stats_object.double_egg_increaser_cost ? Color.fromARGB(255, 128, 255, 119) : Color.fromARGB(162, 244, 67, 54))),
//       height: 70,
//       child: Row(
//         //içerik soldan sağa
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Container(
//             // ikon ve ilerleme
//             width: 90,
//             height: 50,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.0), color: Colors.black),
//             child: Row(
//               children: <Widget>[
//                 Image.asset(
//                   "ourAssets/images/upgradeMenuIcons/eggs.png",
//                   width: 30,
//                   height: 30,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   '${value.upgrade_stats_object.double_egg_increaser_amount}/50',
//                   style: TextStyle(color: Colors.white),
//                 )
//               ],
//             ),
//           ),
//           Text('% Spawn\n2 egg',textAlign: TextAlign.center,),
//           SizedBox(
//               width: 115,
//               height: 50,
//               child: ElevatedButton(
//                   onPressed: () {
//                     if(canIBuy(value.ingame_stats_object.totalMoney,value.upgrade_stats_object.double_egg_increaser_cost)){
//                       if(value.upgrade_stats_object.double_egg_increaser_amount<50){
//                         value.ingame_stats_object.totalMoney-=value.upgrade_stats_object.double_egg_increaser_cost;
//                         value.upgrade_stats_object.double_egg_increaser_amount++;
//                         value.upgrade_stats_object.setNewDoubleEggCost();
//                       }
//                     }
//                   },
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.black),
//                       foregroundColor: MaterialStateProperty.all(Colors.white),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                       )),
//                   child: Text((50 <= value.upgrade_stats_object.double_egg_increaser_amount ? "MAXED" : "${bigIntToString(value.upgrade_stats_object.double_egg_increaser_cost)} \$")),
//             ),
//       )],
//       ),
//     );
//     },);
//   }
// }

class ChanceToEarnWingWidget extends StatefulWidget {
  const ChanceToEarnWingWidget({super.key});

  @override
  State<ChanceToEarnWingWidget> createState() => _ChanceToEarnWingWidgetState();
}

class _ChanceToEarnWingWidgetState extends State<ChanceToEarnWingWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 3),
              color: (value.ingame_stats_object.totalMoney >=
                      value.upgrade_stats_object.wing_at_merge_cost
                  ? Color.fromARGB(255, 128, 255, 119)
                  : Color.fromARGB(162, 244, 67, 54))),
          height: 70,
          child: Row(
            //içerik soldan sağa
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // ikon ve ilerleme
                width: 90,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "ourAssets/images/chicken-wings.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${value.upgrade_stats_object.wing_at_merge_amount}/30',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Text(
                '% Wing\nAt merge',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 115,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (canIBuy(value.ingame_stats_object.totalMoney,
                        value.upgrade_stats_object.wing_at_merge_cost)) {
                      if (value.upgrade_stats_object.wing_at_merge_amount <
                          30) {
                        value.ingame_stats_object.totalMoney -=
                            value.upgrade_stats_object.wing_at_merge_cost;
                        value.upgrade_stats_object.wing_at_merge_amount++;
                        value.upgrade_stats_object.setNewWingAtMergeCost();
                      }
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                  child: Text((30 <=
                          value.upgrade_stats_object.wing_at_merge_amount
                      ? "MAXED"
                      : "${bigIntToString(value.upgrade_stats_object.wing_at_merge_cost)} \$")),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ExpandEggStoreHouseWidget extends StatefulWidget {
  const ExpandEggStoreHouseWidget({super.key});

  @override
  State<ExpandEggStoreHouseWidget> createState() =>
      _ExpandEggStoreHouseWidgetState();
}

class _ExpandEggStoreHouseWidgetState extends State<ExpandEggStoreHouseWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 3),
          color: Color.fromARGB(255, 0, 113, 121)),
      height: 70,
      child: Row(
        //içerik soldan sağa
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // ikon ve ilerleme
            width: 90,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0), color: Colors.black),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "ourAssets/images/upgradeMenuIcons/barn.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '1/30',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Text(
            'Will be\nadded:)',
            textAlign: TextAlign.center,
          ),
          GestureDetector(
              onTap: () {},
              child: UpgradeMenuButton(
                title: '0',
              ))
        ],
      ),
    );
  }
}

class MoreOfflineEarningRateWidget extends StatefulWidget {
  const MoreOfflineEarningRateWidget({super.key});

  @override
  State<MoreOfflineEarningRateWidget> createState() =>
      _MoreOfflineEarningRateWidgetState();
}

class _MoreOfflineEarningRateWidgetState
    extends State<MoreOfflineEarningRateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 3),
          color: Color.fromARGB(255, 0, 113, 121)),
      height: 70,
      child: Row(
        //içerik soldan sağa
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // ikon ve ilerleme
            width: 90,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0), color: Colors.black),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "ourAssets/images/upgradeMenuIcons/sleep.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '1/30',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Text(
            'Will be\nadded:)',
            textAlign: TextAlign.center,
          ),
          GestureDetector(
              onTap: () {},
              child: UpgradeMenuButton(
                title: '0',
              ))
        ],
      ),
    );
  }
}
