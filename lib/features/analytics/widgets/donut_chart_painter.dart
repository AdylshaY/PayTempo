import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutChartData {
  final String category;
  final double amount;
  final Color color;

  const DonutChartData({
    required this.category,
    required this.amount,
    required this.color,
  });
}

class DonutChartPainter extends CustomPainter {
  final List<DonutChartData> dataList;
  final double strokeWidth;

  DonutChartPainter({
    required this.dataList,
    this.strokeWidth = 24.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataList.isEmpty) return;

    final double total = dataList.fold(0, (sum, item) => sum + item.amount);
    if (total == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -math.pi / 2; // Start from top (-90 degrees)

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Round caps look premium with spacing

    // Calculate gap angle if there is more than 1 item
    final double gapAngle = dataList.length > 1 ? 0.06 : 0.0;
    final double totalGaps = gapAngle * dataList.length;
    final double availableAngle = (2 * math.pi) - totalGaps;

    for (final data in dataList) {
      final sweepAngle = (data.amount / total) * availableAngle;
      
      // Don't draw extremely small segments that would cause overlaps with rounded corners
      if (sweepAngle > 0.01) {
        paint.color = data.color;
        // Adjusted to give a spacing look with round stroke caps
        // To avoid overlapping caps when start/end are close, we indent slightly
        final drawStart = startAngle + (gapAngle / 2);
        final drawSweep = sweepAngle - (gapAngle / 2);
        if (drawSweep > 0) {
          canvas.drawArc(rect, drawStart, drawSweep, false, paint);
        }
      }
      
      startAngle += sweepAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return oldDelegate.dataList != dataList || oldDelegate.strokeWidth != strokeWidth;
  }
}
