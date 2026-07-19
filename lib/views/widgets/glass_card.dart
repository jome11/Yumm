import 'dart:ui';
import 'package:flutter/material.dart';

// A "frosted glass" card - whatever is behind it shows through, blurred,
// with a soft tinted panel on top and a bright thin edge around it.
//
// It's a drop-in replacement for the plain cards used across the app:
// same padding/borderRadius/width/margin parameters, just a glass look
// instead of a flat one.
//
// Usage:
//   GlassCard(
//     borderRadius: 20,
//     padding: const EdgeInsets.all(20),
//     child: ...,
//   )
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(16),
    this.blurStrength = 16,
    this.width,
    this.margin,
    this.tintColor,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double blurStrength;
  final double? width;
  final EdgeInsetsGeometry? margin;

  // Optional override for the glass tint - pass a hive's status color
  // here to make the card read as "belonging to" that status instead of
  // the default neutral white glass.
  final Color? tintColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = tintColor ?? Colors.white;

    // A light, mostly-see-through tint. When tintColor is null this is
    // just white (the original neutral glass look) - less of it in dark
    // mode so it doesn't wash out the dark background.
    final tint = isDark ? base.withOpacity(tintColor != null ? 0.20 : 0.08) : base.withOpacity(tintColor != null ? 0.35 : 0.35);
    final edgeHighlight = isDark ? base.withOpacity(tintColor != null ? 0.4 : 0.18) : base.withOpacity(tintColor != null ? 0.55 : 0.6);

    // margin has to live outside the blur/clip - otherwise the margin
    // area would get clipped and blurred along with the card itself.
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: Container(
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: edgeHighlight, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
