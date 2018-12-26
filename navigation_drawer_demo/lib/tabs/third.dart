import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextStyle getCustomFontTextStyle() {
  // text style which defines a custom font
  return const TextStyle(
      // set color of text
      color: Colors.blueAccent,
      // set the font family as defined in pubspec.yaml
      fontFamily: 'Satisfy',
      // set the font weight
      fontWeight: FontWeight.w400,
      // set the font size
      fontSize: 36.0);
}

class Third extends StatefulWidget {
  @override
  ThirdState createState() {
    return new ThirdState();
  }
}

class ThirdState extends State<Third> {
  var nameOfApp = "Persist Key Value";

  var counter = 0;

  // define a key to use later
  var key = "counter";

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<Null> _loadSavedData() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0);
    });
  }

  Future<Null> _onIncrementHit() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0) + 1;
    });

    // Save Value
    prefs.setInt(key, counter);
  }

  Future<Null> _onDecrementHit() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0) - 1;
    });

    // Save Value
    prefs.setInt(key, counter);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(bottom: 8.0),
      decoration: new BoxDecoration(color: Colors.grey[300]),
      child: new Center(
        child: new Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.account_balance,
              size: 160.0,
              color: Colors.blue,
            ),
            new Text(
              "$counter",
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
              style: getCustomFontTextStyle(),
            ),
            new Padding(padding: new EdgeInsets.all(2.0)),
            new RaisedButton(
              onPressed: _onIncrementHit,
              color: Colors.grey,
              elevation: 4.0,
              highlightElevation: 10,
              child: new Text('Increment Counter'),
            ),
            new Padding(padding: new EdgeInsets.all(1.0)),
            new RaisedButton(
              onPressed: _onDecrementHit,
              child: new Text(
                'Decrement Counter',
                style: new TextStyle(fontSize: 14.0, color: Colors.teal[500]),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.left,
              ),
            ),
            new Text(
              'Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS and Android, from a single codebase.',
              style: new TextStyle(fontSize: 20.0, color: Colors.teal[500]),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
