import 'package:flutter/material.dart';

class BottomIndicatorNavigationBarItem {
  final IconData iconData;
  final Color backgroundColor;
  final String label;

  BottomIndicatorNavigationBarItem({
    @required this.iconData,
    this.label,
    this.backgroundColor = Colors.white,
  });
}
