import 'package:flutter/material.dart';
import 'package:flutter_app/topic_page.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/Bar graph.dart';


void main() => runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false, home: HomePage(),
      initialRoute: '/',
      routes: {
        '/topic': (context){return Topic();},
      },
      title: 'CodeForces',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),

    )
);