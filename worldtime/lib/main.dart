import 'package:flutter/material.dart';
import 'package:worldtime/pages/home.dart';
import 'package:worldtime/pages/choose_location.dart';
import 'package:worldtime/pages/loading.dart';
import 'package:worldtime/class.dart';
void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes:{
    '/' : (context) => QQLoading(),
    //'/home': (context) => Home(),
    //'/location': (context) => ChooseLocation(),
},
));

