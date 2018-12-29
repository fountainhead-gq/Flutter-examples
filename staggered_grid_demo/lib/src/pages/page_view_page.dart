import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:staggered_grid_demo/src/layout_type.dart';
import 'package:staggered_grid_demo/src/pages/main_app_bar.dart';

class PageViewPage extends StatelessWidget implements HasLayoutGroup {
  PageViewPage({Key key, this.layoutGroup, this.onLayoutToggle})
      : super(key: key);
  final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  // Widget _buildPage({int index, Color color}) {
  //   return Container(
  //     alignment: AlignmentDirectional.center,
  //     color: color,
  //     child: Text(
  //       '$index',
  //       style: TextStyle(fontSize: 132.0, color: Colors.white),
  //     ),
  //   );
  // }

  final _items = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.red,
  ];

  _buildPageViewindictor() {
    return Container(
      color: Colors.white10,
      height: 545, 
      // padding: const EdgeInsets.all(8.0),     
      child: PageView.builder(
          itemCount: _items.length,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: FlutterLogo(
                colors: _items[index],
                size: 50.0,
              ),
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          size:12.0,
          dotSpacing: 20.0,
          dotColor: Colors.black45,
          // selectedDotColor: Colors.black45,
          selectedSize: 18.0,
          itemCount: _items.length,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  // _buildCircleIndicator2() {
  //   return CirclePageIndicator(
  //     size: 16.0,
  //     selectedSize: 18.0,
  //     itemCount: _items.length,
  //     currentPageNotifier: _currentPageNotifier,
  //   );
  // }

  // Widget _buildPageView() {
  //   return PageView(
  //     children: [
  //       _buildPage(index: 1, color: Colors.green),
  //       _buildPage(index: 2, color: Colors.blue),
  //       _buildPage(index: 3, color: Colors.indigo),
  //       _buildPage(index: 4, color: Colors.red),
  //     ],
  //   );
  // }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildPageViewindictor(),
            _buildCircleIndicator(),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        layoutGroup: layoutGroup,
        layoutType: LayoutType.pageView,
        onLayoutToggle: onLayoutToggle,
      ),
      body: _buildBody(),
    );
  }
}
