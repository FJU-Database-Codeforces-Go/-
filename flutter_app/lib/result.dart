import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_app/problem.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {

  @override
  Widget build(BuildContext context) {

    List data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Result'),),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){

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


