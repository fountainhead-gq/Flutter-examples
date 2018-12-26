import 'package:flutter/material.dart';

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

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.airport_shuttle,
              size: 160.0,
              color: Colors.blue,
            ),
            new Text("Third Tab",
            textAlign: TextAlign.center,
            style: getCustomFontTextStyle(),)
          ],
        ),
      ),
    );
  }
}


