import 'package:flutter/material.dart';
import 'package:flutter_app/problem.dart';
class Topics extends StatefulWidget {
  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  int show = 1;
  //int _value = 1;
  int prating = 1000;
  int rating_index = 0;
  int tags_index = 0;
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
  List<String> selectedChoices = List();
  List<int> selectIndex = List();
  List<Problem> data = List();

  @override
  Widget build(BuildContext context) {
    void initState(){
      super.initState();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text('SELECT TOPICS',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: ListView(
          children: <Widget>[
            Text(
              'NUMBER OF PROBLEM(S)',
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              color: Colors.transparent,
              child: DropdownButton(
                hint: Text('Number of problem',),
                items: [
                  DropdownMenuItem(
                      value: 1,
                      child: Text('1', style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 2,
                      child: Text('2', style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 3,
                      child: Text('3', style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 4,
                      child: Text('4', style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 5,
                      child: Text('5', style: TextStyle(color: Colors.black),)
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    show = value;
                  });
                },
                value: show,
                elevation: 2,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                isDense: true,
                iconSize: 15.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Text('TAG',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.left,

            ),
            SizedBox(height: 10.0,),
            Container(
              color: Colors.transparent,
              child: DropdownButton(
                hint: Text('Please choose a type'),
                items: reportList.map((type){
                  return DropdownMenuItem(
                    child: new Text(type),
                    value: type
                  );
                }).toList(),
                onChanged: (value){
                  setState(() {
                    tags_index = reportList.indexOf(value);
                  });
                },
                value: reportList[tags_index],
                elevation: 2,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                isDense: true,
                iconSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0,),
            /*Wrap(
              children: List<Widget>.generate(
                reportList.length,
                    (int index) {
                  return ChoiceChip(
                    label: Text(reportList[index]),
                    selected: selectIndex.contains(index),
                    onSelected: (bool selected) {
                      setState(() {
                        if((selectIndex).contains(index)){
                          selectIndex.remove(index);
                          selectedChoices.remove(reportList[index]);
                          print(selectedChoices);
                        }
                        else {
                          selectIndex.add(index);
                          selectedChoices.add(reportList[index]);
                          print(selectedChoices);
                        }
                      });
                    },
                  );
                },
              ).toList(),
            ),*/
            SizedBox(height: 20.0,),
            Text('RATING',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox( height:5.0),
            Container(
              color: Colors.transparent,
              child: DropdownButton<int>(
                hint: Text('Difficulty of Problem',),
                items: [
                  DropdownMenuItem(
                      value: 1000,
                      child: Text('0 - 1000',style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 2000,
                      child: Text('1000 - 2000', style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 3000,
                      child: Text('2000 - 3000', style: TextStyle(color: Colors.black),)
                  ),
                  DropdownMenuItem(
                      value: 4000,
                      child: Text('3000 - 4000', style: TextStyle(color: Colors.black),)
                  ),

                ],
                onChanged: (value) {
                  setState(() {
                    prating = value;
                    switch (prating){
                      case 1000:
                        rating_index = 0;
                        break;
                      case 2000:
                        rating_index = 1;
                        break;
                      case 3000:
                        rating_index = 2;
                        break;
                      case 4000:
                        rating_index = 3;
                        break;
                    }
                  });
                },
                value: prating,
                elevation: 2,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                isDense: true,
                iconSize: 15.0,
              ),
            ),
            SizedBox(height: 20.0,),
            FlatButton(
              color: Colors.amberAccent,
              textColor: Colors.black,
              child: Text('ADD'),
              onPressed: (){
                setState(() {
                  for (int i = 0; i < show; i++) {
                    data.add(Problem(tag: tags_index,
                        rating: rating_index,
                        count: 1,
                        name: tags_index));
                    data[data.length - 1].getData();

                  }
                });
              },

            ),
            Divider(height: 40.0,
            color: Colors.grey
            ),
            FlatButton(
              color: Colors.amberAccent,
              textColor: Colors.black,
              child: Text('SEARCH'),
              onPressed: (){
                setState(() {
                  Navigator.pushReplacementNamed(context, '/result',arguments: data);
                });
              },

            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        backgroundColor: Colors.amber[600],
        child: Text('${data.length}',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        )),
        onPressed: ()async{
          await Navigator.pushNamed(context, '/qlist',arguments: data);
  },

      ),
    );
  }
}

