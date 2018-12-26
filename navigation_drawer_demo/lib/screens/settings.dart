import 'package:flutter/material.dart';

// class MySettingsScreen extends StatefulWidget {
//   static const String routName = '/settings';
//   @override
//   SettingsScreen createState() => SettingsScreen();
// }

class SettingsScreen extends StatelessWidget {
  static const String routName = '/settings';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('settings'),
      ),
      body: new Container(
        child: new Center(
          child: new RaisedButton(
            // color: Colors.indigoAccent,
            color: Theme.of(context).accentColor,
            elevation: 4.0,
            splashColor: Colors.blueGrey,
            child: Text('Launch screen'),
            onPressed: () {
              // Navigator.pushNamed(context, '/');
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
