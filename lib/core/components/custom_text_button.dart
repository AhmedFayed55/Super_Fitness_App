import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
    this.textColor,
    this.loadingColor,
    this.fontSize,
    this.fontWeight,
    this.underline = true,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final Color? textColor;
  final Color? loadingColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading
          ? SizedBox(
              width: context.width * 0.05,
              height: context.width * 0.05,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: loadingColor ?? theme.colorScheme.primary,
              ),
            )
          : TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? theme.colorScheme.primary,
                  fontSize: fontSize ?? context.width * 0.043,
                  fontWeight: fontWeight ?? FontWeight.bold,
                  decoration: underline
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
    );
  }
}
