import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final List<CustomTextSpan> textSpans;
  final TextAlign? textAlign;

  const CustomRichText({super.key, required this.textSpans, this.textAlign});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [];

    for (CustomTextSpan span in textSpans) {
      children.add(
        TextSpan(
          recognizer: span.recognizer,
          text: span.text, //openSans
          style: TextStyle(
            decoration: span.decoration ?? TextDecoration.none,
            fontSize: span.fontSize ?? MediaQuery.of(context).size.width / 25,
            fontWeight: span.fontWeight ?? FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontFamily: "ubuntu",
            color: span.textColor ?? Colors.black,
            overflow: TextOverflow.ellipsis,
            height: 1.5,
          ),
        ),
      );
    }

    return RichText(
      textAlign: textAlign == null ? TextAlign.left : textAlign!,
      text: TextSpan(children: children),
    );
  }
}

class CustomTextSpan {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final GestureRecognizer? recognizer;

  CustomTextSpan({
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.decoration,
    this.recognizer,
  });
}
