import 'dart:math';
import 'package:flutter/material.dart';
import 'package:yumm/constants.dart';

// A card with a subtle honeycomb texture watermarked into its top
// corner, fading out toward the rest of the card - the same look as the
// Season Yield card on the Overview screen. Not blurred/see-through;
// it's a normal solid card with a decorative texture baked in.
//
// Usage:
//   HexPatternCard(
//     padding: const EdgeInsets.all(20),
//     child: ...,
//   )
class HexPatternCard extends StatelessWidget {
  const HexPatternCard({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(16),
    this.width,
    this.margin,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // The hex lines use a slightly stronger version of the divider color
    // already used for card borders elsewhere in the app, so it reads as
    // "part of the card," not a random overlay.
    final hexLineColor = isDark ? const Color(0xFF4A4128) : const Color(0xFFD8CFB8);

    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.divider(context)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            // The texture fades out from the top-left corner so it never
            // sits directly behind the numbers/text in the card.
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.transparent],
                    stops: [0.0, 0.75],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: CustomPaint(
                  painter: _HexTexturePainter(lineColor: hexLineColor),
                  size: Size.infinite,
                ),
              ),
            ),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}

class _HexTexturePainter extends CustomPainter {
  _HexTexturePainter({required this.lineColor});

  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    const hexSize = 22.0;
    final hexHeight = hexSize * sqrt(3);
    final step = hexSize * 1.5;

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final columns = (size.width / step).ceil() + 2;
    final rows = (size.height / hexHeight).ceil() + 2;

    for (var col = -1; col < columns; col++) {
      for (var row = -1; row < rows; row++) {
        final x = col * step;
        final y = row * hexHeight + (col.isOdd ? hexHeight / 2 : 0);
        _drawHexagonOutline(canvas, Offset(x, y), hexSize, paint);
      }
    }
  }

  void _drawHexagonOutline(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = (pi / 180) * (60 * i);
      final point = Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HexTexturePainter oldDelegate) => oldDelegate.lineColor != lineColor;
}
