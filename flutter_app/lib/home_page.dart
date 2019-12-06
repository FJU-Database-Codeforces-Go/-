import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';
import 'package:unicorndial/unicorndial.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<LeaderBoard> list = <LeaderBoard>[
    LeaderBoard("Flutter", 54),
    LeaderBoard("React", 22.5),
    LeaderBoard("Ionic", 24.7),
    LeaderBoard("Xamarin", 22.1),
  ];
  LeaderBoard _selectedItem;

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Choo choo",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {
            Navigator.pushNamed(context, '/topic');
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.airplanemode_active),
            onPressed: () {
              Navigator.pushNamed(context, '/topic');
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.directions_car))));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Widget"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            SearchWidget<LeaderBoard>(
              dataList: list,
              hideSearchBoxWhenItemSelected: false,
              listContainerHeight: MediaQuery.of(context).size.height / 4,
              queryBuilder: (query, list) {
                return list
                    .where((item) => item.username
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                    .toList();
              },
              popupListItemBuilder: (item) {
                return PopupListItemWidget(item);
              },
              selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                return SelectedItemWidget(selectedItem, deleteSelectedItem);
              },
              // widget customization
              noItemsFoundWidget: NoItemsFound(),
              textFieldBuilder: (controller, focusNode) {
                return MyTextField(controller, focusNode);
              },
              onItemSelected: (item) {
                setState(() {
                  _selectedItem = item;
                });
              },
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "${_selectedItem != null ? _selectedItem.username : ""
                  "No item selected"}",
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:10.0,horizontal:20),
              color: Colors.lightBlueAccent[100],
              child:Text(
                'Current or upcoming contests',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:20,
                  ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical:40.0,horizontal:10),
              color: Colors.yellowAccent[100],
              child:Column(
                children:[
                  Text(
                  'Codeforces Round #605 (Div. 3)',
                    style: TextStyle(
                      fontSize:15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                Text(
                  'Technocup 2020 - Elimination Round 4',
                  style: TextStyle(
                    fontSize:15,
                  ),
                ),
                ]
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: UnicornDialer(
          parentButtonBackground: Colors.redAccent,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
    );
  }
}

class LeaderBoard {
  LeaderBoard(this.username, this.score);

  final String username;
  final double score;
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final LeaderBoard selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem.username,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.blue[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final LeaderBoard item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.username,
        style: const TextStyle(fontSize: 16),

      ),
    );
  }
}
class ComingContest extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SafeArea(
      //padding: const EdgeInsets.all(20),
      child: Text(
        'Coming contest',
        style: const TextStyle(
        fontSize: 16,
            color: Colors.blue,
        ),
      ),
    );
  }
}