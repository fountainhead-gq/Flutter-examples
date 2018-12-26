import 'package:flutter/material.dart';
import 'package:navigation_drawer_demo/screens/account.dart';
import 'package:navigation_drawer_demo/screens/settings.dart';
import 'package:navigation_drawer_demo/tabs/first.dart';
import 'package:navigation_drawer_demo/tabs/second.dart';
import 'package:navigation_drawer_demo/tabs/third.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<MyHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return new TabBar(
      tabs: <Tab>[
        new Tab(
          // set icon to the tab
          icon: new Icon(Icons.favorite),
        ),
        new Tab(
          icon: new Icon(Icons.add_a_photo),
        ),
        new Tab(
          icon: new Icon(Icons.airport_shuttle),
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = new DrawerHeader(
      child: new Text("Header"),
      decoration: new BoxDecoration(color: Colors.grey[600]),
    );
    // var backgroundColour = new Container(
    //   decoration: new BoxDecoration(color: Colors.grey),
    // );
    var aboutChild = new AboutListTile(
        child: new Text("About"),
        applicationName: "navigation demo",
        applicationVersion: "v1.0.0",
        applicationIcon: new Icon(Icons.adb),
        icon: new Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(s),
        selected: true,
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.settings, "Settings", SettingsScreen.routName),
      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.account_box, "Account", AccountScreen.routName),
      aboutChild
    ];

    ListView listView = new ListView(children: myNavChildren);

    return new Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Navigation Drawer Example"),
      ),
      // body: new Container(
      //   child: new Center(
      //       child: new Column(
      //     children: <Widget>[
      //       new Icon(
      //         Icons.kitchen,
      //         size: 150.0,
      //         color: Colors.limeAccent,
      //       ),
      //       new Text('home screen'),
      //     ],
      //   )),
      // ),
      body: getTabBarView(<Widget>[new First(), new Second(), new Third()]),
      bottomNavigationBar: new Material(
        color: Colors.blueAccent,
        child: getTabBar(),
      ),
      // Set the nav drawer
      drawer: getNavDrawer(context),
    );
  }
}
