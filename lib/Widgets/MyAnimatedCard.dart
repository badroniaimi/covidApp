import 'dart:math';

import 'package:flutter/material.dart';

class MyAnimatedCard extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final List<double> stops;
  final double width;
  final double height;
  final int duration;
  final bool showShadow;
  MyAnimatedCard(
      {required this.child,
      required this.colors,
      required this.stops,
      required this.width,
      required this.height,
      required this.duration,
      this.showShadow = true,
      key})
      : super(key: key);

  @override
  _MyAnimatedCardState createState() => _MyAnimatedCardState();
}

class _MyAnimatedCardState extends State<MyAnimatedCard> {
  static const int FIX_DURATION = 1000;
  Future animate() async {
    await Future.delayed(Duration(milliseconds: widget.duration));
    setState(() {
      animate();
    });
  }

  @override
  void initState() {
    animate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.duration),
      child: widget.child,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: this.widget.showShadow
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 10,
                      offset:
                          Offset(Random().nextDouble(), Random().nextDouble()))
                ]
              : null,
          gradient: LinearGradient(
              stops: widget.stops,
              colors: [
                for (final x in widget.colors)
                  widget.colors[Random().nextInt(widget.colors.length)]
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
    );
  }
}
