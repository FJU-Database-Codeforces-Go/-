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
        appBar: AppBar(
          title: Text('List of Questions'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
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
              child: ListTile(
                onTap: (){},
                title: Text('Tag: ${reportList[data[index].tag]}\nRating: ${rat[data[index].rating]}'),

              ),
            ),
          );
      },
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.reply),
        onPressed:(){
          Navigator.pop(context,data);
        }
      ),
    );
  }
}

