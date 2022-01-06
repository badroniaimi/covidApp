import 'dart:math';

import 'package:anitcorona/Controllers/staticControler.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StaticChartView extends StatelessWidget {
  final StaticController staticController;
  StaticChartView({Key? key, required this.staticController}) : super(key: key);
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        maxY: staticController.value.data.last.toDouble(),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int index = 0;
                  index < staticController.value.data.length;
                  index++)
                FlSpot(index.toDouble(),
                    staticController.value.data[index].toDouble())
            ],
            isCurved: true,
            barWidth: 2,
            colors: [
              Color(ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .value),
              Color(ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .value),
            ],
            aboveBarData: BarAreaData(
              show: true,
              colors: [Colors.lightGreen.withOpacity(0.5)],
              cutOffY: staticController.value.data.last.toDouble(),
              applyCutOffY: true,
            ),
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(show: true, colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
            ]),
          ),
        ],
        minY: staticController.value.data.first.toDouble(),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 5,
              // textStyle: yearTextStyle,
              getTitles: (value) {
                final index = value.toInt();
                return "${staticController.value.xAxis[index].day} ${staticController.value.xAxis[index].month}";
              }),
          leftTitles: SideTitles(
            showTitles: false,
            getTitles: (value) {
              final index = value.toInt();
              return "$index";
            },
          ),
        ),
        axisTitleData: FlAxisTitleData(
            topTitle: AxisTitle(titleText: staticController.value.title))));
  }
}

class LineChartSample2 extends StatefulWidget {
  final StaticController staticController;

  const LineChartSample2({Key? key, required this.staticController})
      : super(key: key);
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff00506a),
    const Color(0xff4f0499),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: const Color(0xff2c4260).withOpacity(0.3),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.5,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 40, bottom: 12),
              child: LineChart(
                avgData(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              child: Text(
                '${widget.staticController.value.title}:   ${widget.staticController.value.data.last}',
                style: TextStyle(
                    fontSize: 20,
                    color:
                        showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getInterval() {
    var r = (widget.staticController.value.data.reduce(max) -
            widget.staticController.value.data.reduce(min))
        .toDouble();
    return r <= 0 ? 1 : r;
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: true),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 2,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            final index = value.toInt();
            return "${widget.staticController.value.xAxis[index].day}";
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          interval: getInterval(),
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            final index = value.toInt();
            return "$index";
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
              bottom: BorderSide(color: const Color(0xff37434d), width: 1),
              left: BorderSide(color: const Color(0xff37434d), width: 1))),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int index = 0;
                index < widget.staticController.value.data.length;
                index++)
              FlSpot(index.toDouble(),
                  widget.staticController.value.data[index].toDouble())
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.5)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.5)!,
          ],
          barWidth: 2,
          isStrokeCapRound: false,
          // dotData: FlDotData(
          //   show: false,
          // ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.2),
          ]),
        ),
      ],
    );
  }
}
