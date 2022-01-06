import 'package:flutter/material.dart';

///this class will do an animation scaled and boom
///[Durution] its 0.5 sec and anothor 0.5 sec
///[note] you can change the [animationController] from the state class
///[note] There is controlers for this class as static you can use them
///to control the animation
class MyScaleAnimation extends StatefulWidget {
  Widget _myWidget;
  int? _dur;
  String? myKey;

  ///this will do backword for all animations
  ///except the exceptions
  static void animateAllbackword({String except = ""}) {
    for (_MyScaleAnimationState X in _MyScaleAnimationState.listOfMe) {
      if (except == X.keyStr) continue;
      X.animationController.animateBack(0.0);
    }
  }

  ///this will do Forward for all animations
  ///except the exceptions
  static void animateAllForward({String except = ""}) {
    for (_MyScaleAnimationState X in _MyScaleAnimationState.listOfMe) {
      if (except == X.keyStr) continue;
      X.animationController.forward();
    }
  }

  ///this will do animation backword for this list
  static void animateBackwordthis(List<String> thisKeys) {
    for (String elme in thisKeys) {
      for (_MyScaleAnimationState X in _MyScaleAnimationState.listOfMe) {
        if (elme == X.keyStr) X.animationController.animateBack(0.0);
      }
    }
  }

  ///this will do animation forward for this list
  static void animateForwardthis(List<String> thisKeys) {
    for (String elme in thisKeys) {
      for (_MyScaleAnimationState X in _MyScaleAnimationState.listOfMe) {
        if (elme == X.keyStr) X.animationController.forward();
      }
    }
  }

  ///this will see if all animations finished there Transition
  static bool isTransitionFinished() {
    for (_MyScaleAnimationState X in _MyScaleAnimationState.listOfMe) {
      if (!X.animationController.isCompleted) return false;
    }
    return true;
  }

  ///This will remove the object that equals to the keystr
  static void removeThisFromMe(String keystr) {
    _MyScaleAnimationState.listOfMe.removeWhere((X) {
      if (X.keyStr == keystr) return true;
      return false;
    });
  }

  ///this will clear all the list
  static void clearAllList() {
    _MyScaleAnimationState.listOfMe.clear();
  }

  MyScaleAnimation(this._myWidget, {int durr = 500, this.myKey}) {
    _dur = durr;
  }
  @override
  _MyScaleAnimationState createState() =>
      _MyScaleAnimationState(_myWidget, _dur, myKey);
}

class _MyScaleAnimationState extends State<MyScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  Widget _myWidget;
  int? dur;
  String? keyStr;
  static List<_MyScaleAnimationState> listOfMe = <_MyScaleAnimationState>[];
  _MyScaleAnimationState(this._myWidget, int? durr, this.keyStr) {
    this.dur = durr;
    listOfMe.add(this);
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: dur!),
    )..addListener(() => setState(() {}));
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.00,
          0.50,
          curve: Curves.linear,
        ),
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    listOfMe.remove(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(
              0.50,
              1.00,
              curve: Curves.linear,
            ),
          ),
        ),
        child: _myWidget,
      ),
    );
  }
}
