import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import '../../constants/color_constant.dart';
import '../text_widget.dart';

class CustomAuthButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color color;
  const CustomAuthButton({
    super.key,
    required this.title,
    this.onTap,
    this.color = customPink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: context.width,
          height: context.height * 0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: color),
          child: Center(
              child: CustomTextWidget(
            text: title,
            color: Colors.white,
          ))),
    );
  }
}
