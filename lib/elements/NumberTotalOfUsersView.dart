import 'package:anitcorona/Database/RealTimeDatabase.dart';
import 'package:anitcorona/Widgets/MyAnimatedCard.dart';
import 'package:anitcorona/Widgets/Number/number_slide_animation_widget.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NumberViewTotalUsersView extends StatefulWidget {
  @override
  _NumberViewTotalUsersViewState createState() =>
      _NumberViewTotalUsersViewState();
}

class _NumberViewTotalUsersViewState extends State<NumberViewTotalUsersView> {
  bool loading = false;
  int number = 0;
  @override
  void initState() {
    loading = true;
    MyRealTimeDatabaseActions.getNumberOfUsersInTheAppNow().then((value) {
      setState(() {
        loading = false;
        number = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: MyAnimatedCard(
          showShadow: false,
          key: ValueKey(loading),
          child: loading
              ? SpinKitThreeBounce(
                  color: Colors.white,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).currentNumberOfOurUsers,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NumberSlideAnimation(
                          number: this.number.toString(),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
          colors: [
            const Color(0xff2c4260).withOpacity(0.3),
            const Color(0xff2c4260).withOpacity(0.5)
          ],
          stops: [0, 0.5],
          width: MediaQuery.of(context).size.width - 5,
          height: MediaQuery.of(context).size.height * 0.15,
          duration: 2000),
    );
  }
}
