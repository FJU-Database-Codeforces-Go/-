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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CODEFORCES",
          style: TextStyle(color: Colors.black, fontFamily: 'BebasNeu',fontWeight: FontWeight.bold,fontSize: 21.0,letterSpacing: 2.0),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 2.0,
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(height: 50.0,),
          new ListTile(
            title: new TextField(
              decoration: InputDecoration(
                hintText: 'Enter Contest ID'
              ),
              controller: _textController,
            ),
          ),
          new ListTile(
            title: new RaisedButton(
                child: new Text('SEARCH', style: TextStyle(color: Colors.black, fontFamily: 'Teko', fontSize: 15.0,letterSpacing: 1.0, fontWeight: FontWeight.bold),),
                color: Colors.amberAccent,
                onPressed: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new MyStatefulWidget(value: _textController.text),
                  );
                  Navigator.of(context).push(route);
                }),
          ),
          SizedBox(height: 30.0,),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            color: Colors.amber[100],
            child: Text(
              'Current or Upcoming Contests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5
              ),
              textAlign: TextAlign.center,
            ),
          ),
          new Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10),
            color: Colors.yellowAccent[100],
            child: Column(children: [
              Text(
                'Codeforces Round #605 (Div. 3)',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Technocup 2020 - Elimination Round 4',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.line_weight,
        ),
        onPressed: ()async{
          await Navigator.pushNamed(context, '/topic');
        },
      )
    );
  }
}