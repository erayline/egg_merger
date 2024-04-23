import 'package:egg_merge/sections/prestigeMenu.dart';
import 'package:egg_merge/sections/statsmenu.dart';
import 'package:egg_merge/sections/upgrademenu.dart';
import 'package:flutter/material.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});
  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: Color.fromARGB(255, 229, 156, 115),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
            IconButton(
            onPressed: (){},
            icon: Icon(Icons.settings_applications,size: 50,),
            highlightColor: Colors.transparent,),

            IconButton(
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) => const StatsMenu(),
              );
            },
            icon: Image.asset('ourAssets/images/easter.png'),
            highlightColor: Colors.transparent,),

      

            IconButton(
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) => const PrestigeMenu(),
              );
            },
            icon: Image.asset('ourAssets/images/egg.png'),
            highlightColor: Colors.transparent,),

            IconButton(
            onPressed: (){
              showDialog(
                context: context,
                builder: (context) => const UpgradeMenu(),
              );
            },
            icon: Image.asset('ourAssets/images/upgrade.png'),
            highlightColor: Colors.transparent,),
            
        ],
      ),
    );
  }
}