import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class QQLoading extends StatefulWidget {
  @override
  _ToLoading createState() => _ToLoading();
}
class _ToLoading extends State<QQLoading>{
  String url;
  void getData() async{
    var response = await http.get('http://140.136.148.222:8000/api/search/?content=1111A');
    var data = jsonDecode(response.body);
    var datas = data[0];
    print(datas['problem_id']);
  }

  @override
  void initState(){
    super.initState();
    //getData();
  }
  @override
  Widget build(BuildContext context){
    getData();
    return Scaffold(
      body: Text('loading screen'),

    );

  }
}