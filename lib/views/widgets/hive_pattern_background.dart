import 'dart:math';
import 'package:flutter/material.dart';

// Draws a scattered honeycomb pattern: a grid of hexagons where each one
// is either just an outline, or filled in with a soft color, picked at
// random (but the same "random" every time, so it doesn't change on
// every rebuild).
//
// Usage:
//   Stack(
//     children: [
//       Positioned.fill(child: HivePatternBackground()),
//       ...your normal screen content...
//     ],
//   )
class HivePatternBackground extends StatelessWidget {
  const HivePatternBackground({
    super.key,
    this.hexagonColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.hexagonSize = 34,
  });

  // The color used for the hexagon outlines and fills.
  final Color hexagonColor;

  // What's behind the hexagons. Leave transparent to show whatever is
  // already behind this widget (e.g. the Scaffold's amber background).
  final Color backgroundColor;

  // How big each hexagon is, measured corner to corner.
  final double hexagonSize;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HoneycombPainter(
        hexagonColor: hexagonColor,
        backgroundColor: backgroundColor,
        hexagonSize: hexagonSize,
      ),
      size: Size.infinite,
    );
  }
}

class _HoneycombPainter extends CustomPainter {
  _HoneycombPainter({
    required this.hexagonColor,
    required this.backgroundColor,
    required this.hexagonSize,
  });

  final Color hexagonColor;
  final Color backgroundColor;
  final double hexagonSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundColor != Colors.transparent) {
      canvas.drawRect(Offset.zero & size, Paint()..color = backgroundColor);
    }

    // A fixed seed means the "random" pattern looks the same every time
    // the screen builds, instead of jumping around.
    final random = Random(7);

    final hexWidth = hexagonSize * 2;
    final hexHeight = hexagonSize * sqrt(3);
    final horizontalStep = hexWidth * 0.75;

    // Draw a couple of extra rows/columns off-screen so hexagons near the
    // edges still look like they continue past the border.
    final columns = (size.width / horizontalStep).ceil() + 2;
    final rows = (size.height / hexHeight).ceil() + 2;

    for (var col = -1; col < columns; col++) {
      for (var row = -1; row < rows; row++) {
        final x = col * horizontalStep;
        final y = row * hexHeight + (col.isOdd ? hexHeight / 2 : 0);

        // Roll the dice for this hexagon: mostly just an outline, with a
        // handful filled in at different opacities for variety - same
        // look as a honeycomb pattern with a few "full" cells.
        final roll = random.nextDouble();
        if (roll < 0.55) {
          _drawHexagon(canvas, Offset(x, y), hexagonSize, outlineOnly: true, opacity: 0.18);
        } else if (roll < 0.80) {
          _drawHexagon(canvas, Offset(x, y), hexagonSize, outlineOnly: false, opacity: 0.12);
        } else {
          _drawHexagon(canvas, Offset(x, y), hexagonSize, outlineOnly: false, opacity: 0.28);
        }
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, {required bool outlineOnly, required double opacity}) {
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

    final paint = Paint()..color = hexagonColor.withOpacity(opacity);
    if (outlineOnly) {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
    } else {
      paint.style = PaintingStyle.fill;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HoneycombPainter oldDelegate) {
    return oldDelegate.hexagonColor != hexagonColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.hexagonSize != hexagonSize;
  }
}
