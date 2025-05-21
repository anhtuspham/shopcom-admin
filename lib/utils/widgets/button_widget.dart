import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_value_key.dart';

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

class RefreshButtonWidget extends StatelessWidget {
  final void Function()? onPressed;

  const RefreshButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Làm mới',
      verticalOffset: 30,
      decoration: const BoxDecoration(
        color: Colors.black38,
      ),
      child: SizedBox(
        height: 50,
        child: FloatingActionButton(
          elevation: 0.0,
          heroTag: 'Làm mới',
          backgroundColor: ColorValueKey.buttonColor,
          hoverColor: ColorValueKey.mainColor,
          onPressed: onPressed,
          child: Icon(
            Icons.refresh,
            size: 24,
            color: ColorValueKey.textColor,
          ),
        ),
      ),
    );
  }
}
