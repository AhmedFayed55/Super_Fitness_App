import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';

class SelectNumber extends StatelessWidget {
  const SelectNumber({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onPressed,
    required this.buttonText,
  });

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

    final double pickerHeight = screenHeight * .12;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: pickerHeight + (screenHeight * .03),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: pickerHeight,
                    child: NumberPicker(
                      axis: Axis.horizontal,
                      itemCount: 5,
                      itemWidth: screenWidth * .20,
                      itemHeight: pickerHeight,
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
                  ),
                ),
                Positioned(
                  top: -5,
                  child: Text(
                    'kg',
                    style: theme.titleSmall!.copyWith(
                      color: colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: screenHeight * .045,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          verticalSpace(context.mdH(31)),

          Padding(
            padding: EdgeInsets.all(screenWidth * .05),
            child: CustomElevatedButton(
              isLoading: false,
              widget: Text(buttonText),
              onPressed: onPressed ?? () {},
            ),
          ),
        ],
      ),
    );
  }
}
