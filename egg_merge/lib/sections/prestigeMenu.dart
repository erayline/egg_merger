import 'package:flutter/material.dart';

class PrestigeMenu extends StatefulWidget {
  const PrestigeMenu({super.key});

  @override
  State<PrestigeMenu> createState() => _PrestigeMenuState();
}

class _PrestigeMenuState extends State<PrestigeMenu> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black12,
      child: Container(
        height: 50,
        width: 50,
        color: Colors.amber,
        child: Text('muhtemelen text olmadığından'),
      ),
    );
  }
}
