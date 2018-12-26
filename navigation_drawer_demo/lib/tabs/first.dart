import 'package:flutter/material.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          // center the children
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.favorite,
              size: 160.0,
              color: Colors.red,
            ),
            new Text(
              "Except as otherwise noted, this work is licensed under a Creative Commons Attribution 4.0 International License, and code samples are licensed under the BSD License.",
              textAlign: TextAlign.start,
              // softWrap: true,
              overflow: TextOverflow.fade,
              maxLines: 2,
              style: new TextStyle(
                fontSize: 22.0,
                color: Colors.redAccent,
              ),
            ),
            new Text('Flutter 是一个用一套代码就可以构建高性能安卓和苹果应用的移动应用',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: new TextStyle(
              fontSize: 24.0,
              color: Colors.tealAccent,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
