import 'package:flutter/material.dart';
import 'package:staggered_grid_demo/src/layout_attribute_selector.dart';

class StackLayoutAttributes extends StatefulWidget {
  StackLayoutAttributes({this.onUpdateType, this.onUpdateAlignment});

  final ValueChanged<int> onUpdateType;
  final ValueChanged<int> onUpdateAlignment;

  @override
  State<StatefulWidget> createState() => StackLayoutAttributesState();
}

class StackLayoutAttributesState extends State<StackLayoutAttributes> {
  bool _alignmentDisabled = false;

  void _updateType(int index) {
    widget.onUpdateType(index);
    setState(() {
      _alignmentDisabled = index == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: LayoutAttributeSelector(
            title: 'Type',
            values: [
              'align',
              'position',
            ],
            onChange: _updateType,
          ),
        ),
        Expanded(
          child: LayoutAttributeSelector(
            title: 'Alignment',
            values: [
              'top\nstart',
              'top\ncenter',
              'top\nend',
              'center\nstart',
              'center',
              'center\nend',
              'bottom\nstart',
              'bottom\ncenter',
              'bottom\nend',
            ],
            disabled: _alignmentDisabled,
            onChange: widget.onUpdateAlignment,
          ),
        ),
      ],
    );
  }
}
