import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'provider demo';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TodoModel(),
      child: MaterialApp(
        title: title,
        theme: ThemeData.light(),
        home: MyHomePage(
          title: title,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTask(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Todo'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[AllTasks(), TodoTask(), DoneTask()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        tooltip: 'add',
        child: Icon(Icons.add),
      ),
    );
  }
}
