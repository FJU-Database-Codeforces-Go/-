import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/getproblem.dart';
import 'package:flutter_app/Bar graph.dart';
import 'package:flutter/cupertino.dart';

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
            builder:(BuildContext context, AsyncSnapshot<List<Listp>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              else if(snapshot.connectionState == ConnectionState.none){
                return Container(
                  child: Center(
                    child: Text("Not found"),
                  ),
                );
              }else if(snapshot.connectionState == ConnectionState.done){
                message = snapshot.data;
                return ListView.builder(
                  itemCount: message.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    var tag = message[index].tags.toString();
                    var rating = message[index].rating.toString();
                    var id = message[index].id;

                    return Card(
                      child: ListTile(
                        title: Text(
                          message[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'tags: $tag\nrating: $rating\nID:$id',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: (Icon(Icons.arrow_downward)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder:(context) => new BarChartSample1(id)
                              )
                            );
                          },
                        ),
                        onTap: () {
                          _launchURL(message[index].link);
                        },
                        isThreeLine: true,

                      ),

                    );

                    },

                );
              }else{
                return Container(
                  child: Center(
                    child: Text("Not found"),
                  ),
                );
              }
            }),
      ),
    );
  }

  _launchURL(String str) async {
    String url = 'https://$str';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SlowMaterialPageRoute<T> extends MaterialPageRoute<T> {
  SlowMaterialPageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => const Duration(seconds: 3);
}
