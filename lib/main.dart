import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quartine Time Tracker',
      theme: ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.white,
        // canvasColor: Colors.blueGrey.shade100,
      ),
      home: StartTime(),
      debugShowCheckedModeBanner: false,
    );
  }
  // #enddocregion build
}

class Time {
  DateTime timeStart = DateTime.now();
  DateTime timeFinish = DateTime.now();
  Duration timeLength = new Duration(seconds: 0);
}

class StartTimeState extends State<StartTime> {
  // final List<WordPair> _suggestions = <WordPair>[];
  final Set<Time> _saved = <Time>{};
  var tracking = false;
  var times = {};
  var start = DateTime.now();
  var end = DateTime.now();
  Duration length = new Duration(seconds: 0);
  //Time structure {
  // Start: timestamp,
  // end: Timestamp,
  // length: float,
  //}

  Widget _buildRow(Time pair) {
  final bool alreadySaved = _saved.contains(pair);  // Add this line.
      // final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.timeLength.toString(),
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(
          () {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          },
        );
      },
    );

}
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quartine Time tracker"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {openPage(context);}
                )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              RaisedButton(
                color: Colors.blueGrey,
                onPressed: () {
                  tracking = true;
                  start = new DateTime.now();
                  print(start);
                  // start++;
                },
                child: const Text('Start Tracking',
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 30),
              FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    tracking = false;
                    end = DateTime.now();
                    length = end.difference(start);
                    Time pair = new Time();
                    pair.timeStart = start;
                    pair.timeFinish = end;
                    pair.timeLength = end.difference(start);
                    setState(() {
                      length = end.difference(start);
                       _saved.add(pair);
                    });
                    print(length);
                  },
                  child: Text(
                    "Stop tracking",
                    style: TextStyle(fontSize: 20),
                  )),
              Text('$length')
            ],
          ),
        ));
  }
  void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
   builder: (BuildContext context) {
        final tiles = _saved.map(
          (Time pair) {
            return ListTile(
              title: Text(
                pair.timeLength.toString(),
              ),
            );
          },
        );
        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          // Add 6 lines from here...
          appBar: AppBar(
            title: Text('Historical Times'),
          ),
          body: ListView(children: divided),
        ); // ... to here.
      },
  ));
}
}

class StartTime extends StatefulWidget {
  @override
  StartTimeState createState() => new StartTimeState();
}



// void _pushSaved() {
//   Navigator.of(context).push(
//     MaterialPageRoute<void>(
//       builder: (BuildContext context) {
//         final tiles = _saved.map(
//           (Time pair) {
//             return ListTile(
//               title: Text(
//                 pair.length.toString(),
//               ),
//             );
//           },
//         );
//         final List<Widget> divided = ListTile.divideTiles(
//           context: context,
//           tiles: tiles,
//         ).toList();

//         return Scaffold(
//           // Add 6 lines from here...
//           appBar: AppBar(
//             title: Text('Saved Suggestions'),
//           ),
//           body: ListView(children: divided),
//         ); // ... to here.
//       },
//     ),
//   );
// }

class _saved {
}

class ViewTime extends StatefulWidget {
  @override
  _ViewTimeState createState() => _ViewTimeState();
}

class _ViewTimeState extends State<ViewTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Time"),
        actions: <Widget>[],
      ),
      body: Center(child: Text("Time")),
    );
  }
}
