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
        height: 400,
        width: 200,
        decoration: BoxDecoration(border: Border.all(width:3),
            borderRadius: BorderRadius.circular(15.0),
            color: Color.fromARGB(255, 219, 183, 122)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('PRESTIGE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black87),),
            Container(
                width: 180,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(width:3),
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
                  border: Border.all(width:3),

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
                  border: Border.all(width:2),
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
                  if(value.ingame_stats_object.willGainAmountPrestigePoint>0){
                    value.ingame_stats_object.prestigeFunction(value.EggIndexList,value.upgrade_stats_object);
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
        ),
      ),
    );
    });
  }
}
