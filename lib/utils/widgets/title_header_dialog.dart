import 'package:flutter/material.dart';

import '../color_value_key.dart';

class TitleHeaderDialog extends StatelessWidget {
  final TextAlign? textAlign;
  final String title;
  const TitleHeaderDialog({
    super.key,
    required this.title,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontSize: 30,
        color: ColorValueKey.textColor,
      ),
      textAlign: textAlign,
    );
  }
}
