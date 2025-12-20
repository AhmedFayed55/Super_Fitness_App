import 'package:flutter/material.dart';

/// Custom shimmer widget without external dependencies
/// 
/// Usage:
/// ```dart
/// CustomShimmer(
///   child: Container(
///     width: 100,
///     height: 50,
///     decoration: BoxDecoration(
///       color: Colors.grey,
///       borderRadius: BorderRadius.circular(8),
///     ),
///   ),
/// )
/// ```
class CustomShimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color? highlightColor;
  final Gradient? gradient;

  const CustomShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.highlightColor,
    this.gradient,
  });

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: widget.gradient?.colors ?? [
                Colors.transparent,
                widget.highlightColor ?? Colors.white.withOpacity(0.3),
                Colors.transparent,
              ],
              stops: [
                _clamp(_animation.value - 1),
                _clamp(_animation.value),
                _clamp(_animation.value + 1),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }

  double _clamp(double value) {
    return value.clamp(0.0, 1.0);
  }
}

/// Simple shimmer box widget with gradient animation
/// 
/// Usage:
/// ```dart
/// ShimmerBox(
///   width: 100,
///   height: 50,
///   radius: 8,
/// )
/// ```
class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double? radius;
  final Color? color;
  final Color? highlightColor;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius,
    this.color,
    this.highlightColor,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.color ?? Colors.grey.shade700,
                (widget.color ?? Colors.grey.shade700).withOpacity(0.5),
                widget.highlightColor ?? Colors.white.withOpacity(0.3),
                (widget.color ?? Colors.grey.shade700).withOpacity(0.5),
                widget.color ?? Colors.grey.shade700,
              ],
              stops: [
                _clamp(_animation.value - 1),
                _clamp(_animation.value - 0.5),
                _clamp(_animation.value),
                _clamp(_animation.value + 0.5),
                _clamp(_animation.value + 1),
              ],
            ),
          ),
        );
      },
    );
  }

  double _clamp(double value) {
    return value.clamp(0.0, 1.0);
  }
}
