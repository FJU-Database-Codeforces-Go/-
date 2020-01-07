import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_app/problem.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  
  _launchURL(String str) async {
    String url = 'https://$str';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {

    List data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.grey[100],
        title: Text(
          'RESULT',
          style: TextStyle(
            color: Colors.black87,
            letterSpacing: 0.5
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Card(
              color: Colors.amber[300],
              child: ListTile(
                onTap: (){
                  _launchURL(data[index].link);
                },
                title: Text(
                    'Problem ID: ${data[index].problem_id}\nName: ${data[index].rname}\nRating: ${(data[index].rrating)}\nTag: ${data[index].rtag}\nLink: ${data[index].link}'),
                leading: Text('${index+1}'),

              ),
            ),
          );
        },
      )

      );

  }



      /*body: NativeDataTable.builder(
          rowsPerPage: _rowsPerPage,
          itemCount: data.length,
          firstRowIndex: _rowsOffset,
          handleNext: () async {
            setState(() {
              _rowsOffset += _rowsPerPage;
            });
          },
          handlePrevious: () {
            setState(() {
              _rowsOffset -= _rowsPerPage;
            });
          },


          itemBuilder: (int index){
            final Problem problem = data[index];
            Map value = getdata(index);
            return DataRow.byIndex(
                cells: null
            );
          }
      ),*/

  }


