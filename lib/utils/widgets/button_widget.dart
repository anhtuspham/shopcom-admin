import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final void Function()? callBack;
  final String label;
  final TextStyle? style;
  final ButtonStyle? buttonStyle;
  final bool? isUppercase;

  const CommonButtonWidget(
      {super.key,
      required this.callBack,
      required this.label,
      this.buttonStyle,
      this.style,
      this.isUppercase = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callBack,
      style: buttonStyle ??
          const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              side: WidgetStatePropertyAll(BorderSide(color: Colors.grey))),
      child: Text(isUppercase == true ? label.toUpperCase() : label,
          style: style ?? const TextStyle(color: Colors.black)),
    );
  }
}
