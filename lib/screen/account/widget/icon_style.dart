import 'package:flutter/material.dart';
import '../../../src/constant.dart';

class IconStyle {
  Color? iconsColor;
  bool? withBackground;
  Color? backgroundColor;
  double? borderRadius;

  IconStyle({
    this.iconsColor = Colors.white,
    this.withBackground = true,
    this.backgroundColor = clrPrimary,
    borderRadius = 8,
  }) : borderRadius = double.parse(
          borderRadius!.toString(),
        );
}
