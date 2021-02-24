import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_bar_item.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  final Color indicatorColor;
  final Color activeColor;
  final Color inactiveColor;
  final double barHeight;
  int currentIndex;
  IconData iconData;
  final double indicatorHeight;
  final ValueChanged<int> onTap;
  final Duration indicatorAnimDuration;
  final bool changeLabelColorOnSelect;
  final List<BottomIndicatorNavigationBarItem> items;

  BottomNavBar({
    Key key,
    @required this.onTap,
    @required this.items,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.indicatorColor,
    this.currentIndex = 0,
    this.barHeight = 60.0,
    this.indicatorAnimDuration = const Duration(milliseconds: 250),
    this.indicatorHeight = 2.5,
    this.changeLabelColorOnSelect = false,
  })  : assert(items.length >= 2),
        super(key: key);

  @override
  State createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<BottomIndicatorNavigationBarItem> get items => widget.items;

  double width = 0;
  Color activeColor;
  Duration duration;

  double getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr)
      return lerpDouble(-1.0, 1.0, index / (items.length - 1));
    else
      return lerpDouble(1.0, -1.0, index / (items.length - 1));
  }

  @override
  void initState() {
    super.initState();
    widget.iconData = widget.items[0].iconData;
    duration = widget.indicatorAnimDuration;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor ?? Theme.of(context).indicatorColor;

    return Container(
      height: widget.barHeight + MediaQuery.of(context).viewPadding.bottom,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: widget.indicatorHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () => select(index, item),
                  child: buildItemWidget(item, index == widget.currentIndex),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 0,
            width: width,
            child: AnimatedAlign(
              alignment:
                  Alignment(getIndicatorPosition(widget.currentIndex), 0),
              curve: Curves.linear,
              duration: duration,
              child: Container(
                color: widget.indicatorColor ?? activeColor,
                width: width / items.length,
                height: widget.indicatorHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  select(int index, BottomIndicatorNavigationBarItem item) {
    widget.currentIndex = index;
    widget.iconData = item.iconData;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  Widget setIcon(BottomIndicatorNavigationBarItem item, bool isSelected) {
    return Icon(
      item.iconData,
      color: isSelected ? activeColor : widget.inactiveColor,
      size: 26.0,
    );
  }

  Widget setLabel(BottomIndicatorNavigationBarItem item, bool isSelected) {
    return Text(
      item.label,
      style: Get.textTheme.subtitle2.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: widget.changeLabelColorOnSelect
              ? isSelected
                  ? widget.activeColor
                  : Get.textTheme.subtitle2.color
              : Get.textTheme.subtitle2.color),
    );
  }

  Widget buildItemWidget(
      BottomIndicatorNavigationBarItem item, bool isSelected) {
    return Container(
      color: item.backgroundColor,
      height: widget.barHeight,
      width: width / items.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          setIcon(item, isSelected),
          SizedBox(
            height: 5,
          ),
          item.label != null ? setLabel(item, isSelected) : Container(),
        ],
      ),
    );
  }
}
