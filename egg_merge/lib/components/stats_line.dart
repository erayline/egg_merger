
import 'package:flutter/material.dart';

class StatsLineWidget extends StatefulWidget {
  final String infoName;
  final String infoItself;
  final Color color;
  const StatsLineWidget(
      {super.key,
      required this.color,
      required this.infoName,
      required this.infoItself});

  @override
  State<StatsLineWidget> createState() => _StatLinesWidgetState();
}

class _StatLinesWidgetState extends State<StatsLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 230,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Center(
          child: Text(
        "${widget.infoName}: ${widget.infoItself}",
        style: TextStyle(fontSize: 14, color: Colors.white),
      )),
    );
  }
}
