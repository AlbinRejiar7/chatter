import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.textInputAction,
    this.labelText,
    required this.keyboardType,
    required this.controller,
    super.key,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
    required this.hintText,
    this.filled = true,
    this.fillColor = const Color.fromARGB(106, 202, 167, 167),
    this.hintStyleColor = Colors.black,
    this.textColor = Colors.black,
  });
  final String hintText;
  final bool? filled;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? labelText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final Color? fillColor;
  final Color? hintStyleColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      validator: validator,
      obscureText: obscureText!,
      obscuringCharacter: '*',
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: hintStyleColor),
        fillColor: fillColor,
        filled: filled,
        contentPadding: EdgeInsets.all(15),
        isCollapsed: true,
        isDense: true,
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(17)),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
