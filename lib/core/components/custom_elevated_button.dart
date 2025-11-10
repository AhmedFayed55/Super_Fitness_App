import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.widget,
    this.loadingColor,
    this.textColor,
    this.containerColor,
  });

  final void Function()? onPressed;
  final bool isLoading;
  final Widget widget;
  final Color? textColor;
  final Color? loadingColor;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: context.height * 0.046,
        width: isLoading
            ? context.width * 0.4
            : MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: isLoading
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: containerColor ?? context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(context.height * 0.1),
                ),
                child: SizedBox(
                  width: context.width * 0.08,
                  height: context.height * 0.03,
                  child: Theme(
                    data: ThemeData(
                      progressIndicatorTheme: ProgressIndicatorThemeData(
                        color: loadingColor ?? context.colorScheme.onPrimary,
                      ),
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              )
            : ElevatedButton(onPressed: onPressed, child: widget),
      ),
    );
  }
}
