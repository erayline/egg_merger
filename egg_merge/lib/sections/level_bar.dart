import 'package:flutter/material.dart';

class levelBar extends StatefulWidget {
  const levelBar({super.key});

  @override
  State<levelBar> createState() => _levelBarState();
}

class _levelBarState extends State<levelBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 255, 205, 41),
      child: Center(child: Text('level 1')),
    );
  }
}