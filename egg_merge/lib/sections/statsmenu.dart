import 'package:egg_merge/funcsFolder/forSaving.dart';
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
            width: 200,
            height: 500,
            decoration: BoxDecoration(border: Border.all(width: 3),color: Color.fromARGB(255, 57, 119, 59),),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 10 sütun
                  mainAxisSpacing: 10.0, // Satırlar arası boşluk
                  crossAxisSpacing: 10.0, // Sütunlar arası boşluk
                ),
                itemCount: 18,
                itemBuilder: (context, index) {
                  return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImageRoutes[index].toString(),
                            color: (index <
                                    value.ingame_stats_object.allTimeEggLevel)
                                ? null:Colors.black),
                      ));
                })),
      );
    });
  }
}
