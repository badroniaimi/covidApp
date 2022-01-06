import 'package:flutter/material.dart';

///this class will do an animation Sized and boom
///[Durution] 1 sec
///[note] you can change the [animationController] from the state class
///[note] There is controlers for this class as static you can use them
///to control the animation
class SizedLoadingAnimation extends StatefulWidget {
  Widget _myWidget;
  int? _dur;
  String? myKey;
  _SizedLoadingAnimationState? _myState;

  ///this will do backword for all animations
  ///except the exceptions
  static void animateAllbackword({String except = ""}) {
    for (_SizedLoadingAnimationState X
        in _SizedLoadingAnimationState.listOfMe) {
      if (except == X.keyStr) continue;
      X.animationController.animateBack(0.0);
    }
  }

  ///this will do Forward for all animations
  ///except the exceptions
  static void animateAllForward({String except = ""}) {
    for (_SizedLoadingAnimationState X
        in _SizedLoadingAnimationState.listOfMe) {
      if (except == X.keyStr) continue;
      X.animationController.forward();
    }
  }

  ///this will do Forward for all animations
  ///except the exceptions
  static void animateThisTo({int index = 0, double to = 0.1}) {
    print(_SizedLoadingAnimationState.listOfMe.length);
    _SizedLoadingAnimationState.listOfMe[index].animationController
        .animateTo(to);
  }

  ///this will do animation backword for this list
  static void animateBackwordthis(List<String> thisKeys) {
    for (String elme in thisKeys) {
      for (_SizedLoadingAnimationState X
          in _SizedLoadingAnimationState.listOfMe) {
        if (elme == X.keyStr) X.animationController.animateBack(0.0);
      }
    }
  }

  ///this will do animation forward for this list
  static void animateForwardthis(List<String> thisKeys) {
    for (String elme in thisKeys) {
      for (_SizedLoadingAnimationState X
          in _SizedLoadingAnimationState.listOfMe) {
        if (elme == X.keyStr) X.animationController.forward();
      }
    }
  }

  ///this will see if all animations finished there Transition
  static bool isTransitionFinished() {
    for (_SizedLoadingAnimationState X
        in _SizedLoadingAnimationState.listOfMe) {
      if (!X.animationController.isCompleted) return false;
    }
    return true;
  }

  ///This will remove the object that equals to the keystr
  static void removeThisFromMe(String keystr) {
    _SizedLoadingAnimationState.listOfMe.removeWhere((X) {
      if (X.keyStr == keystr) return true;
      return false;
    });
  }

  ///this will clear all the list
  static void clearAllList() {
    _SizedLoadingAnimationState.listOfMe.clear();
  }

  SizedLoadingAnimation(this._myWidget, {int durr = 500, this.myKey}) {
    _dur = durr;
  }
  @override
  _SizedLoadingAnimationState createState() =>
      _myState = _SizedLoadingAnimationState(_myWidget, _dur, myKey);

  _SizedLoadingAnimationState? get myState => _myState;

  set myState(_SizedLoadingAnimationState? value) {
    _myState = value;
  }

  int? get dur => _dur;

  set dur(int? value) {
    _dur = value;
  }

  Widget get myWidget => _myWidget;

  set myWidget(Widget value) {
    _myWidget = value;
  }
}

class _SizedLoadingAnimationState extends State<SizedLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation<double>? animation;
  Widget _myWidget;
  int? dur;
  String? keyStr;
  static List<_SizedLoadingAnimationState> listOfMe =
      <_SizedLoadingAnimationState>[];
  _SizedLoadingAnimationState(this._myWidget, int? durr, this.keyStr) {
    this.dur = durr;
    listOfMe.add(this);
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: dur!),
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
    return Container(
      height: 50,
      child: SizeTransition(
        axis: Axis.horizontal,
        axisAlignment: 10,
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Interval(
            0.00,
            1.0,
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        ),
        child: _myWidget,
      ),
    );
  }
}
