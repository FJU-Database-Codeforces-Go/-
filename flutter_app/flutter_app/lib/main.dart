import 'package:flutter/material.dart';
import 'package:flutter_app/qlist.dart';
import 'package:flutter_app/result.dart';
import 'package:flutter_app/topic_page.dart';
import 'package:flutter_app/home_page.dart';


void main() => runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false, home: HomePage(), //isHome
      initialRoute: '/',
      routes: {
        '/topic': (context){return Topics();},
        '/qlist': (context){return QuestionList();},
        '/result': (context){return ShowResult();}
        //'/TopicDetail':(context){return TopicDetail();},
      },
      title: 'CodeForces',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),

    )
);