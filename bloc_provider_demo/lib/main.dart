import 'package:flutter/material.dart';
import 'count_page.dart';
import 'bloc_increment.dart';
import 'bloc_base.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'bloc provider Demo',
      theme: new ThemeData(primaryColor: Colors.lime),
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),
        child: CounterPage(),
      ),
    );
  }
}
