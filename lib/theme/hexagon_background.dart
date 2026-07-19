import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The faint honeycomb watermark seen behind the "Season Yield" card
/// (and, per the request, meant to run behind the whole app).
///
/// Usage — wrap any screen's Scaffold body:
/// ```dart
/// Stack(
///   children: [
///     Positioned.fill(
///       child: HexagonBackground(
///         color: isDark ? AppColors.gold : AppColors.lightTextPrimary,
///         opacity: isDark ? 0.06 : 0.04,
///       ),
///     ),
///     yourScreenContent,
///   ],
/// )
/// ```
class HexagonBackground extends StatelessWidget {
  const HexagonBackground({
    super.key,
    required this.color,
    this.opacity = 0.06,
    this.hexRadius = 34,
  });

  final Color color;
  final double opacity;
  final double hexRadius;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _HexagonPainter(
          color: color.withOpacity(opacity),
          hexRadius: hexRadius,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  _HexagonPainter({required this.color, required this.hexRadius});

  final Color color;
  final double hexRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final double hexWidth = hexRadius * math.sqrt(3);
    final double hexHeight = hexRadius * 2;
    final double vertSpacing = hexHeight * 0.75;

    int row = 0;
    for (double y = -hexHeight; y < size.height + hexHeight; y += vertSpacing) {
      final double xOffset = (row.isOdd) ? hexWidth / 2 : 0;
      for (double x = -hexWidth; x < size.width + hexWidth; x += hexWidth) {
        _drawHexagon(canvas, strokePaint, Offset(x + xOffset, y), hexRadius);
      }
      row++;
    }
  }

  void _drawHexagon(Canvas canvas, Paint paint, Offset center, double r) {
    final Path path = Path();
    for (int i = 0; i < 6; i++) {
      final double angle = math.pi / 180 * (60 * i - 30);
      final Offset point = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
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
  bool shouldRepaint(covariant _HexagonPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.hexRadius != hexRadius;
  }
}
