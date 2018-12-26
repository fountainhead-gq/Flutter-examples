import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const String routName = '/account';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('account'),
      ),
      body: new Container(
        child: new Center(
          child: new Text('account screen'),
        ),
      ),
    );
  }
}
