import 'package:flutter/material.dart';
import 'package:maka_assessment/style/color_palette.dart';

class PrimaryButton extends StatelessWidget {
  /// Constructor
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isEnabled;
  final bool toUppercase;
  final double height;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isEnabled = true,
    this.toUppercase = true,
    this.backgroundColor,
    this.borderColor,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled ? onTap : null,
      style: TextButton.styleFrom(
        backgroundColor:
            isEnabled ? (backgroundColor ?? ColorPalette.yellow70) : ColorPalette.gray30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: borderColor == null
              ? BorderSide.none
              : BorderSide(
                  color: borderColor!,
                ),
        ),
        minimumSize: Size.fromHeight(height),
      ),
      child: Text(
        toUppercase ? label.toUpperCase() : label,
        textAlign: TextAlign.center,
        style: isEnabled
            ? const TextStyle(
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              )
            : const TextStyle(
                color: ColorPalette.gray50,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
      ),
    );
  }
}
