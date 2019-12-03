import 'package:flutter/material.dart';
import 'slide.dart';
import 'quote_card.dart';
void main() => runApp(MaterialApp(
  home: QuoteList(),
));
class QuoteList extends StatefulWidget{
  @override
  _QuoteListState createState() => _QuoteListState();
}
class _QuoteListState extends State<QuoteList>{
  List<Quote> quotes = [
    Quote(author: 'Osca Wilde',text:'Be yourself'),
    Quote(author: 'Osca Wilde',text:'nice'),
    Quote(author: 'Osca Wilde',text:'good'),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.cyan[500],
      ),
        body: Column(
          children: quotes.map((quote) => QuoteCard(
              quote:quote,
              delete:(){
                setState(() {
                  quotes.remove(quote);
                });
              }
          )).toList(),
        )
    );
  }
}