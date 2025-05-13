library chart_lib;

import 'package:chart_lib/chart_painter.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      height: 300,
      width: 400,
      child: CustomPaint(
        painter: LineChartPainter(),
      ),
    );
  }
}
