import 'dart:async';

import 'package:egg_merge/funcsFolder/modeller.dart';
import 'package:egg_merge/funcsFolder/saveload.dart';
import 'package:egg_merge/sections/bottom_bar.dart';
import 'package:egg_merge/sections/game_section.dart';
import 'package:egg_merge/sections/eggObjectModel.dart';
import 'package:egg_merge/sections/spawn_timer.dart';
import 'package:egg_merge/sections/upperBar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    MobileAds.instance.initialize();
  } on Exception{
    print('no internet probably');
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  //  StatefulWidget yerine StatelessWidget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
        ChangeNotifierProvider<EggObjectModel>(create: (context)=>EggObjectModel()),
        ChangeNotifierProvider<UygulamaModeli>(create: (context)=>UygulamaModeli()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        title: 'My App',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Örnek bir ana sayfa
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    createPrestigeMileStones();



    return Scaffold(
      backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              upperBar(),
              inGame(),
              spawnTimer(),
              bottomBar(),
            ],
          ),
        ),
      );

  }
}

