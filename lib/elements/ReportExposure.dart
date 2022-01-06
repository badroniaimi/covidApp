import 'package:anitcorona/Froms/ReportExposure.dart';
import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportExposure extends StatelessWidget {
  const ReportExposure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showExposureReportDialog(context);
      },
      child: Card(
        elevation: 0,
        color: Color(0xff7589a2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).ReportExposure,
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
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      S.of(context).NoExposureMessageReport,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  )
                ],
              ),
              Icon(
                Icons.navigate_next,
                size: 40,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
