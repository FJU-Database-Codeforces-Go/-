import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Search{
  final String url;
  Search(this.url);
  Future<void> getData() async{
    var response = await http.get(
        Uri.encodeFull('http://140.136.148.222:8000/api/search/?content=$url'),
        headers: {
          "Accept" : "application/json"
        }
    );
  }
}