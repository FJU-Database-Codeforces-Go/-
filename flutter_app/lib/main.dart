import 'package:flutter/material.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/topic_page.dart';
void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false, home: Home(),
        initialRoute: '/',
        routes: {
          //'/': (context){return Example();},
          '/topic': (context){return Topic();},
        },
    )
);

