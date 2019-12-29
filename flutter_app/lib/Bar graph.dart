import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_app/home_page.dart';
import 'package:http/http.dart' as http;

class BarChartSample1 extends StatefulWidget {
  final String value;

  BarChartSample1({Key key, @required this.value}) : super(key: key);
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
  String data;
  var datas;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = Duration(milliseconds: 250);
  int touchedIndex;
  bool isPlaying = false;

  Future<String> get(String url) async {
    var response = await http.get(
        Uri.encodeFull(
            'http://140.136.148.222:8000/api/problemDetail/?problemid=$url'),
        headers: {"Accept": "application/json"});
    return response.body;
  }

  setData() async {
    data = await get(widget.value); //getData()延迟执行后赋值给data
  }

  @override
  Widget build(BuildContext context) {
    setData();
    return FutureBuilder<String>(
        future: get(widget.value),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            var json = jsonDecode(data);
            //print(json);
            datas = json[0];
            //print(datas);
            print(datas['submissions']['Wrong answer']);
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }

          return Scaffold(
              body: AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: const Color(0xff81e5cd),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Submissions Statistics',
                          style: TextStyle(
                              color: const Color(0xff0f4a3c),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              isPlaying ? randomData() : mainBarData(),
                              swapAnimationDuration: animDuration,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: const Color(0xff0f4a3c),
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            if (isPlaying) {
                              refreshState();
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
        });
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 40,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          isRound: true,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0, datas['submissions']['Accepeted'].toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                1, datas['submissions']['Wrong answer'].toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2, datas['submissions']['Complie error'].toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3, datas['submissions']['Time limit error'].toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4, datas['submissions']['Memory limit error'].toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                5, datas['submissions']['Runtime error'].toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, datas['submissions']['other'].toDouble(),
                isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay;
                switch (group.x.toInt()) {
                  case 0:
                    weekDay = 'Accepted';
                    break;
                  case 1:
                    weekDay = 'Wrong answer';
                    break;
                  case 2:
                    weekDay = 'Complie error';
                    break;
                  case 3:
                    weekDay = 'Time limit error';
                    break;
                  case 4:
                    weekDay = 'Memory limit error';
                    break;
                  case 5:
                    weekDay = 'Runtime error';
                    break;
                  case 6:
                    weekDay = 'other';
                    break;
                }
                return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                    TextStyle(color: Colors.yellow));
              }),
          touchCallback: (barTouchResponse) {
            setState(() {
              if (barTouchResponse.spot != null &&
                  barTouchResponse.touchInput is! FlPanEnd &&
                  barTouchResponse.touchInput is! FlLongPressEnd) {
                touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
              } else {
                touchedIndex = -1;
              }
            });
          }),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
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
            }),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: const BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
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
            }),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      /*barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0, datas['submissions']['Accepeted'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(
                1, datas['submissions']['Wrong answer'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(
                2, datas['submissions']['Complie error'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(
                3, datas['submissions']['Time limit error'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(
                4, datas['submissions']['Memory limit error'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(
                5, datas['submissions']['Runtime error'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, datas['submissions']['other'].toDouble(),
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return null;
        }
      }),*/
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}
