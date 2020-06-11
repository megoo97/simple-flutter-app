import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) {
    return MaterialApp (
    theme:ThemeData(primaryColor:Colors.purple[900]),
      home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override

  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
    final _RandomWordPair = <WordPair>[];
    final _savedWordPairs = Set<WordPair>();
  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,item) {
        if(item.isOdd) return Divider();
        final index =item ~/ 2;

        if(index>= _RandomWordPair.length) {
          _RandomWordPair.addAll(generateWordPairs().take(10));
        } 

        return _buildRow(_RandomWordPair[index]);
      },

    );

  }

    Widget _buildRow(WordPair pair) {
    final alreadySaved= _savedWordPairs.contains(pair);

    return ListTile(title: Text(pair.asPascalCase,style: TextStyle(fontSize: 18.0)),
    trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, color: alreadySaved ? Colors.red : null),
  onTap: () {
    setState(() {
      if(alreadySaved) {
        _savedWordPairs.remove(pair);
      } else {
        _savedWordPairs.add(pair);
      }
    });
  },        
    );
    }
void _PushSaved() {
Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
final Iterable<ListTile> tiles =_savedWordPairs.map((WordPair pair)  {
return ListTile(
  title: Text(pair.asPascalCase,style: TextStyle(fontSize: 16),),
);
} );

final List<Widget> divided =ListTile.divideTiles(context: context, tiles: tiles).toList();
return Scaffold(appBar: AppBar(title: Text('Saved WordPairs'),), body: ListView(children: divided),);
}));
}
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('WordPair Generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list),
            onPressed: _PushSaved,
            )
          ],
                  ) ,
          body: _buildList()

        );
  }
} 