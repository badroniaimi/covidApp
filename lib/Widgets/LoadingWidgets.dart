import 'package:flutter/material.dart';

class Welcome_While_Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State_Welcoming();
  }
}

class _State_Welcoming extends State<Welcome_While_Loading> {
  static const List<String> _Hello_List = [
    "Bonjour",
    "Un moment",
    "Chargement"
  ];
  int _Index = 0;
  double opacityLevel = 1.0;
  static bool imWorking = false;
  _State_Welcoming() {
    Future.delayed(Duration(milliseconds: 1500), () {
      _changeOpacity();
    });
  }
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    try {
      super.setState(fn);
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        child: AnimatedOpacity(
      opacity: opacityLevel,
      child: Text(
        _Hello_List[_Index],
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.5,
      ),
      duration: Duration(milliseconds: 1500),
      onEnd: () {
        try {
          setState(() {
            if (this.opacityLevel == 0) {
              _Index++;
              if (_Index == _Hello_List.length) {
                _Index = 0;
              }
              opacityLevel = 1;
            } else {
              opacityLevel = 0;
            }
          });
        } catch (e) {}
      },
    ));
  }
}
