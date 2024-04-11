import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class denemeSeti extends ChangeNotifier {
  int money = 0;

  int returnMoney() {
    return this.money;
  }

  Widget increaseMoney() {
    return Consumer<denemeSeti>(builder: ((context, value, child) {
      return ElevatedButton(onPressed: (){
        value.money += 1;
        value.notifyListeners();
      }, child: Text('dene'));
    }));
  }

  Widget denemeSilinecekWidget() {
    return Consumer<denemeSeti>(builder: ((context, value, child) {
      return Text(value.money.toString());
    }));
  }
}
