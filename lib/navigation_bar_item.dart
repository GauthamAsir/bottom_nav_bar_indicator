import 'package:flutter/material.dart';

class BottomIndicatorNavigationBarItem {
  final IconData iconData;
  final String assetActiveIcon;
  final String assetInActiveIcon;
  final Color backgroundColor;
  final String label;

  BottomIndicatorNavigationBarItem({
    @required this.iconData,
    this.assetActiveIcon,
    this.assetInActiveIcon,
    this.label,
    this.backgroundColor = Colors.white,
  }) : assert(iconData == null || assetActiveIcon == null,
            'Cannot provide both icon and image asset');
}
