import 'package:anitcorona/classes/MyNeabyUsers.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class Connections extends StatelessWidget {
  const Connections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xff7589a2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).Connections,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                  ),
                )
              ],
            ),
            Text(
              "${MyNearbyUser.myUsers.length}",
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
