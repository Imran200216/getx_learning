import 'package:flutter/material.dart';

class KTextBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const KTextBtn({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color ?? Theme.of(context).primaryColor,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        label,
        style: textStyle ?? const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
