import 'package:flutter/material.dart';
import 'package:staggered_grid_demo/src/layout_type.dart';
import 'package:staggered_grid_demo/src/pages/expanded_page.dart';
import 'package:staggered_grid_demo/src/pages/baseline_page.dart';
import 'package:staggered_grid_demo/src/pages/hero_page.dart';
import 'package:staggered_grid_demo/src/pages/list_page.dart';
import 'package:staggered_grid_demo/src/pages/nested_page.dart';
import 'package:staggered_grid_demo/src/pages/padding_page.dart';
import 'package:staggered_grid_demo/src/pages/page_view_page.dart';
import 'package:staggered_grid_demo/src/pages/row_column_page.dart';
import 'package:staggered_grid_demo/src/pages/slivers_page.dart';
import 'package:staggered_grid_demo/src/pages/stack_page.dart';
import 'package:staggered_grid_demo/src/pages/staggered_grid.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LayoutGroup _layoutGroup = LayoutGroup.nonScrollable;
  LayoutType _layoutSelection1 = LayoutType.rowColumn;
  LayoutType _layoutSelection2 = LayoutType.pageView;

  void _onLayoutGroupToggle() {
    setState(() {
      _layoutGroup = _layoutGroup == LayoutGroup.nonScrollable
          ? LayoutGroup.scrollable
          : LayoutGroup.nonScrollable;
    });
  }

  void _onLayoutSelected(LayoutType selection) {
    setState(() {
      if (_layoutGroup == LayoutGroup.nonScrollable) {
        _layoutSelection1 = selection;
      } else {
        _layoutSelection2 = selection;
      }
    });
  }

  void _onSelectTab(int index) {
    if (_layoutGroup == LayoutGroup.nonScrollable) {
      switch (index) {
        case 0:
          _onLayoutSelected(LayoutType.rowColumn);
          break;
        case 1:
          _onLayoutSelected(LayoutType.baseline);
          break;
        case 2:
          _onLayoutSelected(LayoutType.stack);
          break;
        case 3:
          _onLayoutSelected(LayoutType.expanded);
          break;
        case 4:
          _onLayoutSelected(LayoutType.padding);
          break;
      }
    } else {
      switch (index) {
        case 0:
          _onLayoutSelected(LayoutType.pageView);
          break;
        case 1:
          _onLayoutSelected(LayoutType.list);
          break;
        case 2:
          _onLayoutSelected(LayoutType.slivers);
          break;
        case 3:
          _onLayoutSelected(LayoutType.hero);
          break;
        case 4:
          _onLayoutSelected(LayoutType.nested);
          break;
        case 5:
          _onLayoutSelected(LayoutType.staggered);
          break;
      }
    }
  }

  Color _colorTabMatching({LayoutType layoutSelection}) {
    if (_layoutGroup == LayoutGroup.nonScrollable) {
      return _layoutSelection1 == layoutSelection ? Colors.orange : Colors.grey;
    } else {
      return _layoutSelection2 == layoutSelection ? Colors.orange : Colors.grey;
    }
  }

  BottomNavigationBarItem _buildItem(
      {IconData icon, LayoutType layoutSelection}) {
    String text = layoutName(layoutSelection);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(layoutSelection: layoutSelection),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(layoutSelection: layoutSelection),
        ),
      ),
    );
  }

  Widget _buildBody() {
    LayoutType layoutSelection = _layoutGroup == LayoutGroup.nonScrollable
        ? _layoutSelection1
        : _layoutSelection2;
    switch (layoutSelection) {
      case LayoutType.rowColumn:
        return RowColumnPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.baseline:
        return BaselinePage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.stack:
        return StackPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.expanded:
        return ExpandedPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.padding:
        return PaddingPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.pageView:
        return PageViewPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.list:
        return ListPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.slivers:
        return SliversPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.hero:
        return HeroPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.nested:
        return NestedPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
      case LayoutType.staggered:
        return StaggeredGridPage(
            layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
    }
    return null;
  }

  Widget _buildBottomNavigationBar() {
    if (_layoutGroup == LayoutGroup.nonScrollable) {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(
              icon: Icons.view_headline, layoutSelection: LayoutType.rowColumn),
          _buildItem(
              icon: Icons.format_size, layoutSelection: LayoutType.baseline),
          _buildItem(icon: Icons.layers, layoutSelection: LayoutType.stack),
          _buildItem(
              icon: Icons.line_weight, layoutSelection: LayoutType.expanded),
          _buildItem(
              icon: Icons.format_line_spacing,
              layoutSelection: LayoutType.padding),
        ],
        onTap: _onSelectTab,
      );
    } else {
      return BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        type: BottomNavigationBarType.shifting,
        items: [
          _buildItem(
              icon: Icons.view_week, layoutSelection: LayoutType.pageView),
          _buildItem(
              icon: Icons.format_list_bulleted,
              layoutSelection: LayoutType.list),
          _buildItem(icon: Icons.view_day, layoutSelection: LayoutType.slivers),
          _buildItem(icon: Icons.gradient, layoutSelection: LayoutType.hero),
          _buildItem(icon: Icons.dashboard, layoutSelection: LayoutType.nested),
          _buildItem(icon: Icons.grain, layoutSelection: LayoutType.staggered),
        ],
        onTap: _onSelectTab,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
