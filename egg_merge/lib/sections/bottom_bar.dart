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
            onPressed: (){},
            icon: Image.asset('ourAssets/images/easter.png'),
            highlightColor: Colors.transparent,),

            IconButton(
            onPressed: (){},
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

class clickableWidget extends StatefulWidget {
  const clickableWidget({super.key});

  @override
  State<clickableWidget> createState() => _clickableWidgetState();
}

class _clickableWidgetState extends State<clickableWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
            onPressed: (){},
            icon: Image.asset('ourAssets/images/upgrade.png'),
            highlightColor: Colors.transparent,);
  }
}







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
        height: 500,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 235, 134, 40),
        ),
      ),
    );
  }
}
