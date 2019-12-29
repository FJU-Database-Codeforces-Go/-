import 'dart:convert';

import 'package:http/http.dart';

class P {
  String url;

  P(this.url);

  Future <List<Listp>> getData() async {
    Response response = await get(
        'http://140.136.148.222:8000/api/search/?content=$url');
    var data = jsonDecode(response.body);
    print(data);
    List<Listp> list= [];

    for(var d in data){
      Listp  l = Listp(d['problem_id'],d['name'],d['rating'],d['tags'],d['link']);
      list.add(l);
    }
    return list;
  }

  Future <tag> getData2() async {
    Response response = await get(
        'http://140.136.148.222:8000/api/problemDetail/?problemid=$url');
    var data = jsonDecode(response.body);
    var tags = data[0];
    tag t = new tag(tags['submissions']['Accepeted'],tags['submissions']['Wrong answer'],
    tags['submissions']['Complie error'],tags['submissions']['Time limit error'],
        tags['submissions']['Memory limit error'],tags['submissions']['Runtime error'],
    tags['submissions']['other']);

    return t;
  }
}

class Listp{
  String id;
  String name;
  int rating;
  List<dynamic> tags;
  String link;
  Listp(this.id,this.name,this.rating,this.tags,this.link);
}

class tag{
  int AC;
  int WA;
  int CE;
  int TLE;
  int MLE;
  int RE;
  int other;
  tag(this.AC,this.WA,this.CE,this.TLE,this.MLE,this.RE,this.other);
}