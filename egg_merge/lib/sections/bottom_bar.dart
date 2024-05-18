import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:egg_merge/sections/prestigeMenu.dart';
import 'package:egg_merge/sections/statsmenu.dart';
import 'package:egg_merge/sections/upgrademenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});
  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        color: Color.fromARGB(255, 227, 132, 77),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const StatsMenu(),
                );
              },
              icon: Image.asset('ourAssets/images/easter.png'),
              highlightColor: Colors.transparent,
            ),

            (value.ingame_stats_object.gameProgressionLevel>=1 ? 
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const PrestigeMenu(),
                );
              },
              icon: Image.asset('ourAssets/images/egg.png'),
              highlightColor: Colors.transparent,
            ): SizedBox(width: 0,)),
            

            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const UpgradeMenu(),
                );
              },
              icon: Image.asset('ourAssets/images/upgrade.png'),
              highlightColor: Colors.transparent,
            ),
          ],
        ),
      );
    });
  }
}
