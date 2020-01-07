import 'package:flutter/material.dart';
import 'package:flutter_app/problem.dart';

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List data = List();
  List<String> reportList = [
    'expression parsing',
    'combinatorics',
    'binary search',
    'hashing',
    'Bishop and King',
    'dp',
    'not B or not C?',
    'Svyatoslav and Maps',
    'Vishtasp and Eidi',
    'Win Easy'
  ];
  List<String> rat = [
    '0 - 1000',
    '1000 - 2000',
    '2000 - 3000',
    '3000 - 4000',
  ];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 1.0,
          title: Text(
              'QUESTION LIST',
                style: TextStyle(
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
          ),
          automaticallyImplyLeading: false,

        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
          child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index){
            final item = data[index];
            return Dismissible(
              key: Key(item.toString()),
              onDismissed: (direction){

                  data.removeAt(index);

              },
              background: Container(color: Colors.red),
              child: Card(
                color: Colors.amber[300],
                elevation: 1.0,
                child: ListTile(
                  onTap: (){},
                  title: Text(
                    'Tag: ${reportList[data[index].tag]}\nRating: ${rat[data[index].rating]}',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),

                ),
              ),
            );
      },
    ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.reply,color: Colors.black87,),
        onPressed:(){
          Navigator.pop(context,data);
        }
      ),
    );
  }
}

