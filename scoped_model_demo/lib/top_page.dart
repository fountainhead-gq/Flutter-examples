import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'count_model.dart';
import 'under_page.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  //静态获取model用法实例
  Model getModel(BuildContext context) {
    //直接使用of,rebuildOnChange=true同步刷新
    final countModel =
        ScopedModel.of<CountModel>(context, rebuildOnChange: true);
    //使用CountModel中重写的of
    final countModel2 = CountModel().of(context);

    countModel.increment();
    countModel2.increment();
    return countModel;
    //    return countMode2;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Top Screen'),
          ),
          body: Center(
            child: Text(
              model.count.toString(),
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return UnderScreen(
                  title: "Under Screen",
                );
              }));
            },
            child: Icon(Icons.forward),
          ),
        );
      },
    );
  }
}
