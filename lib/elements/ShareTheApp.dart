import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class ShareTheApp extends StatelessWidget {
  const ShareTheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xff7589a2),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).InviteOthers,
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
