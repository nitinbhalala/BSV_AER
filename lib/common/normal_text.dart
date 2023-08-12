import 'package:flutter/material.dart';

class NormalText extends Text {
  NormalText(String data,
      {Key? key,
        FontWeight? fontWeight=FontWeight.w400,
        required double fontSize,
        required Color color,
        TextAlign? textAlign,
        TextDecoration? textDecoration,
        TextOverflow? overflow,
        int? maxLines})
      : super(data,
      key: key,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        decoration: textDecoration,
      )
  );
}
