import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  const TextButtonWidget({super.key, this.onPressed, required this.child, this.style});

  @override
  Widget build(BuildContext context) {
    final btnStyle = style ?? ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return ElevatedButton(
      style: btnStyle,
      onPressed: onPressed,
      child: child,
    );
  }
}

class TextButtonTableWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  const TextButtonTableWidget({super.key, this.onPressed, required this.child, this.style});

  @override
  Widget build(BuildContext context) {
    final btnStyle = style ?? TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );
    return TextButton(
      style: btnStyle,
      onPressed: onPressed,
      child: child,
    );
  }
}