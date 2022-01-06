import 'package:anitcorona/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportExposure extends StatefulWidget {
  const ReportExposure({Key? key}) : super(key: key);

  @override
  _ReportExposureState createState() => _ReportExposureState();
}

class _ReportExposureState extends State<ReportExposure> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
        color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: size.height * 0.24, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: size.height * 0.3,
          width: size.width * 0.8,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).ReportExposure,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black87),
                        ),
                        IconButton(
                            padding: EdgeInsets.only(bottom: 20),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 30,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        S.of(context).ExposureReportBody1,
                        style: bodyStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        S.of(context).ExposureReportBody2,
                        style: bodyStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        S.of(context).ExposureReportBody3,
                        style: bodyStyle,
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xff7589a2).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                              hintText: S.of(context).ExposureID),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: InkWell(
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Color(0xff7589a2).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0)
                                .add(EdgeInsets.symmetric(vertical: 5)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).Report,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[800]),
                                  ),
                                  Icon(Icons.send, color: Colors.grey[700]),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Color(0xff7589a2).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0)
                            .add(EdgeInsets.symmetric(vertical: 5)),
                        child: InkWell(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).DontHaveID,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[800]),
                                ),
                                Icon(Icons.send, color: Colors.grey[700]),
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future showExposureReport(BuildContext context) => showModalBottomSheet(
    context: context, enableDrag: true, builder: (_) => ReportExposure());

Future showExposureReportDialog(BuildContext context) =>
    showDialog(context: context, builder: (_) => ReportExposure());
