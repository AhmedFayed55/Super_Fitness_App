import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/features/auth/register/presentation/widget/custom_blur_page_view.dart';
import 'package:numberpicker/numberpicker.dart';
class SelectNumber extends StatelessWidget {
  const SelectNumber({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onPressed,
    required this.buttonText,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final Function(int) onChanged;
  final void Function()? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context).textTheme;

    return Center(
      child: CustomBlurPageView(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            SizedBox(height: screenHeight * .05),
            Text(
              label,
              style: theme.bodySmall?.copyWith(color: colorScheme.primary),
            ),

            Stack(
              alignment: Alignment.center,
              children: [
                NumberPicker(
                  axis: Axis.horizontal,
                  itemCount: 5,
                  itemWidth: screenWidth * .20,
                  itemHeight: screenHeight * .10,
                  value: value,
                  minValue: min,
                  maxValue: max,
                  selectedTextStyle: theme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontSize: 40,
                  ),
                  textStyle: theme.titleLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontSize: 27,
                  ),
                  onChanged: onChanged,
                ),

                Positioned(
                  bottom: -screenHeight * .02,
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: screenHeight * .05,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * .03),
            Padding(
              padding: EdgeInsets.all(screenWidth * .05),
              child: CustomElevatedButton(
                isLoading: false,
                widget: Text(buttonText),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
