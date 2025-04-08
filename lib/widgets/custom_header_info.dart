import 'package:flutter/cupertino.dart';

class CustomHeaderInfo extends StatelessWidget {
  final String title;
  final String value;
  final double? headerWidth;
  final double? fontSize;
  final FontWeight? headerFontWeight;
  final FontWeight? infoFontWeight;

  const CustomHeaderInfo(
      {super.key,
        required this.title,
        required this.value,
        this.headerWidth = 150,
        this.fontSize = 18,
        this.headerFontWeight = FontWeight.w400,
        this.infoFontWeight = FontWeight.w400});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: headerWidth,
            child: Text('$title: ',
                style: TextStyle(
                    fontSize: fontSize, fontWeight: headerFontWeight))),
        Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize, fontWeight: infoFontWeight),
              softWrap: true,
            ))
      ],
    );
  }
}
