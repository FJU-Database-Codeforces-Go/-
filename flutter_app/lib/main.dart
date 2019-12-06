import 'package:flutter/material.dart';
import 'package:flutter_app/topic_page.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/topic_detail.dart';

void main() => runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false, home: HomePage(),
      initialRoute: '/',
      routes: {
        '/topic': (context){return Topic();},
        '/TopicDetail':(context){return TopicDetail();},
      },
      title: 'CodeForces',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),

    )
);