import 'package:flutter/material.dart';

class KVerticalSpacer extends StatelessWidget {
  final double height;

  const KVerticalSpacer({super.key, this.height = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
