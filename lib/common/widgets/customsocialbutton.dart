import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor,
      this.elevation = 1,
      this.shadowColor = Colors.transparent,
      required this.isBordered,
      required this.imagePath,
      required this.imageSize});
  final double width;
  final double height;
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final bool isBordered;
  final double? elevation;
  final Color? shadowColor;
  final String imagePath;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isBordered ? Theme.of(context).colorScheme.surface : color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: isBordered
                  ? BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1.5)
                  : BorderSide.none,
            ),
            elevation: elevation,
            shadowColor: shadowColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isBordered
                        ? Theme.of(context).colorScheme.primary
                        : textColor),
              ),
            ],
          ),
        ));
  }
}
