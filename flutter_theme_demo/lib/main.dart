import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(new MyHome());

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
  backgroundColor: Colors.brown[200],
);

final ThemeData kAndroidTheme = new ThemeData(
  // primarySwatch: Colors.lime,
  primaryColor: Colors.green[300],
  accentColor: Colors.orangeAccent[300],
  primaryColorBrightness: Brightness.light,
  backgroundColor: Colors.brown[600],
);

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'flutter theme demo',
      // theme: new ThemeData(
      //   primaryColor: Colors.greenAccent,
      //   accentColor: Colors.lightGreenAccent,
      //   backgroundColor: Colors.black26,
      // ),
      //根据平台类型设置对应的主题
      theme: defaultTargetPlatform == TargetPlatform.android
          ? kAndroidTheme
          : kIOSTheme,
      home: new MyHomePage(title: 'Flutter Theme Demo '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // AppBar
      appBar: new AppBar(
        // AppBar Title
        // title: new Text("Flutter Theme"),
        title: new Text(widget.title),
      ),
      body: new Container(
        // Another way to set the background color
        decoration: new BoxDecoration(color: Colors.white30),
        child: new Center(
          child: new Container(
            // use the theme accent color as background color for this widget
            color: Theme.of(context).accentColor,
            child: new Text(
              'click the button times: $_counter',
              // Set text style as per theme
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),

      floatingActionButton: new Theme(
        // override the accent color of theme for this widget only
        data: Theme.of(context).copyWith(accentColor: Colors.pinkAccent[400]),
        child: new FloatingActionButton(
          onPressed: _incrementCounter,
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
