import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import 'pages/custom_column_nested_table.dart';
//import 'pages/custom_column_table.dart';
import 'pages/simple_table.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  enablePlatformOverrideForDesktop();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Table Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlueAccent[300],
      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Table Widget"),
        ),
        body: TabBarView(
          children: <Widget>[
            SimpleTable(),
            //CustomColumnTable(),
            //CustomColumnNestedTable(),
          ],
        ),
      ),
    );
  }
}
