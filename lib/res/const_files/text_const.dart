
import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';

class TextConst extends StatelessWidget {
  const TextConst({
    super.key,
    this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.maxLines,
    this.decoration,
    this.textAlign,
    this.textOverflow, this.decorationColor,
  });
  final String? title;
  final Color? color;
  final Color? decorationColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.center,
      title ?? '',
      style: TextStyle(
          decoration: decoration,
          decorationColor:decorationColor ,
          color: color ?? AppColor.black54,
          fontSize: fontSize ?? textFontSize20,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontFamily: fontFamily ?? 'ubuntu'),
      overflow: textOverflow ?? TextOverflow.ellipsis,
    );
  }
}
