import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../color_value_key.dart';

class InputForm extends TextFormField {
  InputForm({
    super.key,
    String? hintText,
    required String labelText,
    bool isRequired = false,
    bool enable = true,
    String? Function(String? value)? validator,
    List<TextInputFormatter> inputFormatters = const [],
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? prefixText,
    // super.validator,
    super.initialValue,
    super.readOnly,
    super.onSaved,
    super.enabled,
    super.onTap,
    super.onChanged,
    super.controller,
    super.maxLines,
    super.obscureText,
    super.minLines,
    super.mouseCursor,
    super.showCursor,
    super.enableInteractiveSelection,
    super.focusNode,
    super.autofocus,
  }) : super(
    validator: (value) {
      if (isRequired) {
        if (value == null || value.trim().isEmpty) {
          return "Please fill info";
        }
      }
      return validator?.call(value);
    },
    inputFormatters: inputFormatters,
    decoration: InputDecoration(
      // labelText: labelText,
      errorStyle: TextStyle(color: ColorValueKey.errorTextColor), // 0xecfd5c5c
      enabled: enable,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefix: prefixText != null ?Builder(
        builder: (context) {
          if (prefixText.length > 15) {
            return Tooltip(
              message: prefixText,
              child: Text(
                '${prefixText.substring(0, 15)}..._',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          } else {
            return Text(
              '${prefixText}_',
              style: const TextStyle(
                color: Colors.grey,
              ),
            );
          }
        },
      ): const Offstage(),
      label: Text.rich(
        TextSpan(
          text: labelText,
          style: TextStyle(color: ColorValueKey.textColor),
          children: isRequired
              ? [
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ]
              : null,
        ),
      ),

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      hintText: hintText,
    ),
  );
}

