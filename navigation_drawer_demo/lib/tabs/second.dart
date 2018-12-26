import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.add_a_photo,
              size: 160.0,
              color: Colors.green,
            ),
            new Text(
              "home screen 2",
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            new RichText(
                text: new TextSpan(
              text: ' The second screen will contain a richtext ',
              // style: DefaultTextStyle.of(context).style,
              style: new TextStyle(
                fontSize: 22.0,
                color: Colors.yellowAccent[700],
              ),
              children: <TextSpan>[
                new TextSpan(
                    text: 'second screen',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.purpleAccent[400],
                    )),
                new TextSpan(
                  text: ' hahaha',
                  style: new TextStyle(
                    fontSize: 24.0,
                    color: Colors.tealAccent[700],
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple,
                    decorationStyle: TextDecorationStyle.wavy,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
