import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isPassword,
      required this.keyboardType,
      required this.width,
      required this.height,
      required this.isBordered,
      required this.backgroundColor,
      required this.textColor,
      required this.borderColor,
      required this.hintColor,
      this.leadingIcon});

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final double width;
  final double height;
  final bool isBordered;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color hintColor;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isBordered ? borderColor : Colors.transparent,
          width: isBordered ? 2 : 0,
        ),
      ),
      child: Row(
        children: [
          if (leadingIcon != null) leadingIcon!,
          if (leadingIcon != null) const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              keyboardType: keyboardType,
              style: TextStyle(
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintColor,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
