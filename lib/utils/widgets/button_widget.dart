import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class CreateButtonWidget extends ConsumerWidget {
  final void Function()? callBack;
  final bool? isTopWidget;
  final String tooltip;
  final double? sizeIcon;
  const CreateButtonWidget({
    super.key,
    required this.callBack,
    this.isTopWidget,
    this.sizeIcon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: tooltip,
      child: SizedBox(
        height:  50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: ColorValueKey.lineButtonBorder),
            shape: RoundedRectangleBorder(
              borderRadius: isTopWidget != null ? BorderRadius.circular(5) : BorderRadius.circular(8),
            ),
            backgroundColor: ColorValueKey.mainColor,
            foregroundColor: ColorValueKey.btnTextColor,
          ),
          onPressed: callBack,
          child:  Icon(
            Icons.add,
            size: sizeIcon ?? 24,
            color: ColorValueKey.textColor,
          ),

        ),
      ),
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
