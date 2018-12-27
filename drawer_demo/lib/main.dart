import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Tutorial",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // primaryIconTheme: new IconThemeData(color: Colors.black),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void _openPage(context, String title) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => DetailPage(title)));
  }

  void _closePage(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: new Text('Header'),
              decoration: new BoxDecoration(color: Colors.black12),
            ),
            UserAccountsDrawerHeader(
              accountName: Text("Jack"),
              accountEmail: Text("jack@gmail.com"),
              decoration: BoxDecoration(color: Colors.orange),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("avatar.png"),
                radius: 10.0,
                backgroundColor: Colors.black26,
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Text("A"),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Text("B"),
                ),
              ],
            ),
            ListTile(
              leading: new CircleAvatar(child: new Text("P")),
              title: Text("Page 1"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _openPage(context, "Page 1 Detail"),
            ),
            ListTile(
              title: Text("Page 2"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _openPage(context, "Page 2 Detail"),
            ),
            ListTile(
              title: Text("close App"),
              trailing: Icon(Icons.close),
              onTap: () async => _closePage(context),
            ),
            AboutListTile(
              icon: new CircleAvatar(child: new Text("Ab")),
              child: new Text('About'),
              applicationName: "Test",
              applicationVersion: "1.0",
              // applicationIcon: new Image.asset("avatar.png",width: 64.0,height: 64.0,),
              applicationIcon: new Container(width: 64.0,height: 64.0),
              applicationLegalese: "applicationLegalese",
              aboutBoxChildren: <Widget>[
                new Text("BoxChildren"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  DetailPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: new TextStyle(fontSize: 22.0),
        ),
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
