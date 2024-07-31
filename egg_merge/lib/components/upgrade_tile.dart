import 'package:egg_merge/funcsFolder/numberFormating.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UpgradeTileWidget extends StatefulWidget {
  final String upgradeImageRoute;
  final int upgradeLimit;
  final int upgradedAmount;
  final String upgradeName;
  final Function()? upgradeFunction;
  final BigInt upgradeCost;

  const UpgradeTileWidget({super.key,
  required this.upgradeImageRoute, required this.upgradeLimit, required this.upgradedAmount, required this.upgradeName, required this.upgradeFunction, required this.upgradeCost});

  @override
  State<UpgradeTileWidget> createState() =>
      _UpgradeTileWidgetState();
}

class _UpgradeTileWidgetState extends State<UpgradeTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EggObjectModel>(builder: (context, value, child) {

    return Container(
      decoration: BoxDecoration(border: Border.all(width:3),color: (value.ingame_stats_object.totalMoney>=value.upgrade_stats_object.double_egg_increaser_cost ? Color.fromARGB(255, 128, 255, 119) : Color.fromARGB(162, 244, 67, 54))),
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
                  widget.upgradeImageRoute,
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.upgradedAmount}/${widget.upgradeLimit}',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Text(widget.upgradeName,textAlign: TextAlign.center,),
          SizedBox(
              width: 115,
              height: 50,
              child: ElevatedButton(
                  onPressed: widget.upgradeFunction,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                  child: Text((widget.upgradeLimit <= widget.upgradedAmount ? "MAXED" : "${bigIntToString(widget.upgradeCost)} \$")),
            ),
      )],
      ),
    );
    },);
  }
}