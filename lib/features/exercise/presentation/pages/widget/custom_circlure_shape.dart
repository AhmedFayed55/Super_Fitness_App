import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomCirclureShape extends StatelessWidget {
  final Widget child;
  const CustomCirclureShape({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: 0.5, color: Colors.white),
        borderRadius: BorderRadius.circular(context.mdRadius(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: child),
      ),
    );
  }
}
