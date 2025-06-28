import 'package:flutter/material.dart';

class KHorizontalSpacer extends StatelessWidget {
  final double width;

  const KHorizontalSpacer({super.key, this.width = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
