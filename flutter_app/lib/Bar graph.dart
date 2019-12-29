import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/getproblem.dart';
import 'dart:ui';



class BarChartSample1 extends StatefulWidget {
  BarChartSample1(this.value) : super();
  final String value;

  //BarChartSample1({Key key, @required this.value}) : super(key: key);
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = Duration(milliseconds: 250);
  int touchedIndex;


  @override
  Widget build(BuildContext context) {

    P p = new P(widget.value);
    return FutureBuilder(
        future: p.getData2(),
        builder: (BuildContext context, AsyncSnapshot<tag> snapshot) {
          if (snapshot.hasData) {
            tag message = snapshot.data;
              return new BarChartSample3State(t : message);
          }else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),

            );
          }
          return new Container();
        }
        );
  }
}

class BarChartSample3State extends StatelessWidget {
  final tag t;

  BarChartSample3State({Key key, @required this.t}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: BarChart(
          BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 200,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: const EdgeInsets.all(0),
                  tooltipBottomMargin: 8,
                  getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                      ) {
                    return BarTooltipItem(
                      rod.y.round().toString(),
                      TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                      color: const Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                  margin: 20,
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'AC';
                      case 1:
                        return 'WA';
                      case 2:
                        return 'CE';
                      case 3:
                        return 'TLE';
                      case 4:
                        return 'MLE';
                      case 5:
                        return 'RE';
                      case 6:
                        return 'other';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: const SideTitles(showTitles: false),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(y: t.AC.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(y: t.WA.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(y: t.CE.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(y: t.TLE.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(y: t.MLE.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(y: t.RE.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
                BarChartGroupData(
                    x: 4,
                    barRods: [BarChartRodData(y: t.other.toDouble(), color: Colors.lightBlueAccent)],
                    showingTooltipIndicators: [0]),
              ]),
        ),
      ),
    );
  }

}
