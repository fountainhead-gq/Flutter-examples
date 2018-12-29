import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_grid_demo/src/layout_type.dart';

class StaggeredGridPage extends StatefulWidget implements HasLayoutGroup {
  StaggeredGridPage({Key key, this.layoutGroup, this.onLayoutToggle})
      : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  @override
  _StaggeredGridPageState createState() => _StaggeredGridPageState();
}

class _StaggeredGridPageState extends State<StaggeredGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageTile(),
    );
  }
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
];

List<Widget> _tiles = const <Widget>[
  const _ImageTile('assets/test2.jpg'),
  const _ImageTile('assets/test3.jpg'),
  const _ImageTile('assets/test4.jpg'),
  const _ImageTile('assets/test5.jpg'),
  const _ImageTile('assets/test6.jpg'),
  const _ImageTile('assets/test7.jpg'),
  const _ImageTile('assets/test8.jpg'),
  const _ImageTile('assets/test9.jpg'),
  const _ImageTile('assets/test10.jpg'),
  const _ImageTile('assets/test11.jpg'),
  const _ImageTile('assets/test12.jpg'),
  const _ImageTile('assets/test13.jpg'),
  const _ImageTile('assets/test14.jpg'),
  const _ImageTile('assets/test8.jpg'),
  const _ImageTile('assets/test9.jpg'),
  const _ImageTile('assets/test10.jpg'),
  const _ImageTile('assets/test11.jpg'),
  const _ImageTile('assets/test12.jpg'),
  const _ImageTile('assets/test13.jpg'),
  const _ImageTile('assets/test14.jpg'),
];

class ImageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Staggered Image Grid'),
        ),
        body: new Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            )));
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.gridImage);

  final gridImage;

  @override
  Widget build(BuildContext context) {
    return new Card(
      // color: const Color(0x00000000),
      color: Colors.black54,
      elevation: 0.0,
      child: new GestureDetector(
        onTap: () {
          print("hello");
        },
        child: new Container(
            decoration: new BoxDecoration(
          image: new DecorationImage(
            // image: new NetworkImage(gridImage),
            image: new AssetImage(gridImage),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(const Radius.circular(2.0)),
        )),
      ),
    );
  }
}
