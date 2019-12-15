import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/json_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:http/http.dart' as http;

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Choo choo",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {
            Navigator.pushNamed(context, '/topic');
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "airplane",
          backgroundColor: Colors.greenAccent,
          mini: true,
          child: Icon(Icons.airplanemode_active),
          onPressed: () {
            Navigator.pushNamed(context, '/TopicDetail');
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.directions_car))));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Widget"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _textController,
            ),
          ),
          new ListTile(
            title: new RaisedButton(
                child: new Text('Next'),
                onPressed: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new MyStatefulWidget(value: _textController.text),
                  );
                  Navigator.of(context).push(route);
                }),
          ),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            color: Colors.lightBlueAccent[100],
            child: Text(
              'Current or upcoming contests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
            color: Colors.yellowAccent[100],
            child: Column(
                children: [
                  Text(
                    'Codeforces Round #605 (Div. 3)',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Technocup 2020 - Elimination Round 4',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ]
            ),
          ),

        ],

      ),
      floatingActionButton: UnicornDialer(
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
    );
  }
  Future<String> getData(String url) async {
    var response = await http.get(
        Uri.encodeFull('http://140.136.148.222:8000/api/search/?content=$url'),
        headers: {
          "Accept": "application/json"
        }
    );
    return response.body;
  }
}
class MyStatefulWidget extends StatefulWidget {
  final String value;
  MyStatefulWidget({Key key,@required this.value}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  Future<String> getData(String url) async {
    var response = await http.get(
        Uri.encodeFull('http://140.136.148.222:8000/api/search/?content=$url'),
        headers: {
          "Accept": "application/json"
        }
    );
    return response.body;
  }
  String data;
  setData() async {
    data = await getData(widget.value);    //getData()延迟执行后赋值给data
  }

  //Future future;
  Widget build(BuildContext context) {
    bool toggle = true;
    setData();
    return FutureBuilder<String>(
      future: getData(widget.value), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          //setData();
          var json = jsonDecode(data);
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(16.0),
              child: toggle
                  ? Column(
                children: [
                  JsonTable(
                    json,
                    showColumnToggle: true,
                    tableHeaderBuilder: (String header) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            color: Colors.grey[300]),
                        child: Text(
                          header,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Colors.black87),
                        ),
                      );
                    },
                    tableCellBuilder: (value) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5,
                                color: Colors.grey.withOpacity(0.5))),
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontSize: 14.0, color: Colors.grey[900]),
                        ),
                      );
                    },
                    allowRowHighlight: true,
                    rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
                    paginationRowCount: 4,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              )
                  : Center(
                child: Text(getPrettyJSONString(data)),

              ),
            ),
          );
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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}
/*
class TopicDetail extends StatefulWidget {
  final String value;

  TopicDetail({Key key, @required this.value}) : super(key: key);

  @override
  _TopicDetail createState() => _TopicDetail();
}

class _TopicDetail extends State<TopicDetail> {

  @override
  Widget build(BuildContext context) {
    String url = widget.value;
    bool toggle = true;
    return new Scaffold(
      body: buildFutureBuilder(),
    )
  }


}
*/




