import 'dart:math' as math;
import 'package:flutter/material.dart';

class HoneycombPattern extends StatelessWidget {
  final double size;
  final Color color;

  const HoneycombPattern({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _HoneycombPainter(color: color),
        ),
      ),
    );
  }
}

class _HoneycombPainter extends CustomPainter {
  final Color color;

  _HoneycombPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Use a smaller radius to fit more hexagons in the same area
    final double r = 15.0;

    // Use a fixed seed for stable "randomness"
    final random = math.Random(42);

    final centerOffset = Offset(size.width / 2, size.height / 2);

    // Grid dimensions: roughly 5 columns x 6 rows
    for (int q = -2; q <= 2; q++) {
      for (int row = -3; row <= 2; row++) {
        // Skip probability: roughly 1 in 6 (16.7%)
        if (random.nextDouble() < 0.167) continue;

        // Center calculation for flat-top hexagons
        final cx = centerOffset.dx + r * 1.5 * q;
        final cy = centerOffset.dy + r * math.sqrt(3) * (row + q / 2.0);

        _drawHexagon(canvas, cx, cy, r, paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, double cx, double cy, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
