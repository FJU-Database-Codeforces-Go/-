import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:flutter_app/Bar graph.dart';
import 'package:flutter_app/search.dart';
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
          new Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
            color: Colors.yellowAccent[100],
            child: Column(children: [
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
            ]),
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
}