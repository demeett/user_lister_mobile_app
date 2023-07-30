import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get xScreenHeight => MediaQuery.of(this).size.height;
  double get xScreenWidth => MediaQuery.of(this).size.width;
}
