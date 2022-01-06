import 'package:flutter/material.dart';

class FeedAnimation extends StatefulWidget {
  Widget? _MyWidget;
  static const int _Time_D = 1500;
  FeedAnimation(Widget Widget, {int Time = _Time_D}) {
    _MyWidget = Widget;
  }
  static void StopAnimation() {
    _Fade_Widget_State._controller.dispose();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Fade_Widget_State(_MyWidget, Time: _Time_D);
  }
}

class _Fade_Widget_State extends State<FeedAnimation>
    with TickerProviderStateMixin {
  Widget? _MyWidget;
  bool _visable = true;
  static const int _Time_D = 1500;

  _Fade_Widget_State(Widget, {int Time = _Time_D}) {
    _MyWidget = Widget;
  }

  static late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: _Time_D), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        child: FadeTransition(opacity: _animation, child: _MyWidget));
  }
}
