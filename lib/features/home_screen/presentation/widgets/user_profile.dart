import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Hi UserName ,\n",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: "Let’s start your day",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const CircleAvatar(radius: 36, backgroundColor: Color(0xFFFF4100)),
      ],
    );
  }
}
