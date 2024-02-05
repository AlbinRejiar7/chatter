import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextWidget extends StatelessWidget {
  final String text;
  FontWeight? fontWeight;
  Color? color;
  double? fontSize;

  CustomTextWidget(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 15,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Text(
        text,
        style:
            TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
      ),
    );
  }
}
