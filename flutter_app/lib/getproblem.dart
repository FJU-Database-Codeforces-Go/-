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
}

class Listp{
  String id;
  String name;
  int rating;
  List<dynamic> tags;
  String link;
  Listp(this.id,this.name,this.rating,this.tags,this.link);
}