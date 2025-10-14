import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final int? maxLine;
  final TextAlign textAlign;

    CustomText(
      {Key? key,
        required this.text,
        this.textAlign = TextAlign.start,
        this.maxLine,
        required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,

      style: style,
      maxLines: maxLine,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
class CustomTextAuto extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final int? maxLine;
  final TextAlign textAlign;

  CustomTextAuto(
      {Key? key,
        required this.text,
        this.textAlign = TextAlign.start,
        this.maxLine,
        required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text!,

      style: style,
      maxFontSize: 14,
      minFontSize: 8,
      maxLines: maxLine,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
