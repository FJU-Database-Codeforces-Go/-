import 'dart:convert';

import 'package:http/http.dart';

class Problem {
  int id;
  int name;
  int rating;
  int tag;
  int count;

  String problem_id;
  String rname;
  int rrating;
  List<dynamic> rtag;
  String link;

  Problem({this.tag, this.rating, this.count, this.name});

  Future <void> getData() async {
      Response response = await get(
          'http://140.136.148.222:8000/api/selectProblem/?type=$tag&degree=$rating&count=1');
      Map<String ,dynamic> data = jsonDecode(response.body)[0];
      problem_id = data['problem_id'];
      rname = data['name'];
      rrating = data['rating'];
      rtag = data['tags'];
      link = data['link'];

  }
}