import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:path_drawing/path_drawing.dart';

class DashedSquare extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final double iconSize;
  final IconData icon;
  final double borderRadius;
  const DashedSquare(
      {this.size = 50,
      this.color = Colors.grey,
      this.strokeWidth = 1,
      required this.icon,
      required this.borderRadius,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: DashedSquarePainter(
          color: color,
          strokeWidth: strokeWidth,
          icon: icon,
          borderRadius: borderRadius,
          iconSize: iconSize),
    );
  }
}

class DashedSquarePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  DashedSquarePainter({
    required this.color,
    required this.strokeWidth,
    this.borderRadius = 0,
    required this.icon,
    this.iconSize = 24,
    this.iconColor = kPrimaryColorLight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[5.0, 5.0]),
      ),
      paint,
    );

    if (icon != null) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontSize: iconSize,
            color: iconColor,
            fontFamily: icon.fontFamily,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      double x = (size.width - textPainter.width) / 2;
      double y = (size.height - textPainter.height) / 2;
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
