import 'package:flutter/material.dart';

class CustomBarText extends StatelessWidget {
  const CustomBarText({
    super.key,
    required this.text1,
    required this.text2,
    this.key1,
    this.key2,
  });
  final String text1;
  final String text2;
  final Key? key1;
  final Key? key2;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * .05),
          child: Text(
            key: key1,
            text1,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 20),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            left: width * .05,
            bottom: height * .02,
            top: height * .01,
          ),
          child: Text(
            text2,
            key: key2,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
