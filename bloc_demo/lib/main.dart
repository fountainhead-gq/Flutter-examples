import 'package:flutter/material.dart';
import 'top_page.dart';
import 'bloc_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'rxdart',
        theme: ThemeData.dark(),
        home: TopPage(),
      ),
    );
  }
}
