import 'package:flutter/material.dart';

class GeometricShapesPainter extends CustomPainter {
  final bool isDark;

  GeometricShapesPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = isDark
          ? Colors.white.withOpacity(0.1)
          : const Color(0xFF667EEA).withOpacity(0.15);

    // Draw multiple geometric shapes
    _drawCircles(canvas, size, paint);
    _drawLines(canvas, size, paint);
  }

  void _drawCircles(Canvas canvas, Size size, Paint paint) {
    // Top left circle
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      80,
      paint,
    );

    // Bottom right circle
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.6),
      120,
      paint,
    );

    // Center top circle
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.2),
      60,
      paint,
    );
  }

  void _drawLines(Canvas canvas, Size size, Paint paint) {
    // Horizontal line on left
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.5),
      Offset(size.width * 0.3, size.height * 0.5),
      paint,
    );

    // Horizontal line on right
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.4),
      Offset(size.width * 0.9, size.height * 0.4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GeometricShapesPainter oldDelegate) {
    return isDark != oldDelegate.isDark;
  }
}