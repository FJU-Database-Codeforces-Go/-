import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:flutter_app/getproblem.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyStatefulWidget extends StatefulWidget {
  final String value;

  MyStatefulWidget({Key key, @required this.value}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var message;

  Widget build(BuildContext context) {
    P p = new P(widget.value);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Search result'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: FutureBuilder(
            future: p.getData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Listp>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              else {
                message = snapshot.data;

                return ListView.builder(
                  itemCount: message.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    var tag = message[index].tags.toString();
                    var rating = message[index].rating.toString();
                    return Card(
                      child: ListTile(
                        title: Text(
                            message[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'tags: $tag\nrating: $rating',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        trailing: IconButton(
                          icon: (Icon(Icons.arrow_downward)),
                          onPressed: () {
                            print('hello');
                          },
                        ),
                        //Text()
                        onTap: () {
                          _launchURL(message[index].link);
                        },
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}

_launchURL(String str) async {
  String url = 'https://$str';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Post {
  String problemId;
  String name;
  String rating;
  List tags;
  String link;
}
