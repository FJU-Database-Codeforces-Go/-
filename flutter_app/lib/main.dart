import 'package:flutter/material.dart';
import 'package:flutter_app/topic_page.dart';
import 'package:flutter_app/home_page.dart';

void main() => runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false, home: HomePage(),
      initialRoute: '/',
      routes: {
        '/topic': (context){return Topic();},
      },
      title: 'Search Widget',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),

    )
);