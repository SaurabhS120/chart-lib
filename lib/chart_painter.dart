
import 'dart:math';

import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  static const double chartPadding = 12.0;
  static const double horizontalGapBetweenGraph = 24.0;
  static const double verticalGapBetweenGraph = 24.0;
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    // Fill circle
    final axisPainter = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    final graphPainter = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke;
    final axisInterceptPoint = Offset(chartPadding, height-chartPadding);
    final xAxisEndPoint = Offset(width-chartPadding, height-chartPadding);
    final yAxisEndPoint = Offset(chartPadding, chartPadding);
    // x-axis line
    canvas.drawLine(axisInterceptPoint, xAxisEndPoint, axisPainter);
    // y-axis line
    canvas.drawLine(axisInterceptPoint, yAxisEndPoint, axisPainter);
    // vertical lines
    for(double x =chartPadding+horizontalGapBetweenGraph;x<xAxisEndPoint.dx;x+=horizontalGapBetweenGraph){
      final verticalLineTopPoint = Offset(x, chartPadding);
      final verticalLineBottomPoint = Offset(x, axisInterceptPoint.dy);
      canvas.drawLine(verticalLineTopPoint, verticalLineBottomPoint, graphPainter);
    }
    // horizontal lines
    for(double y =xAxisEndPoint.dy;y>chartPadding+verticalGapBetweenGraph;y-=verticalGapBetweenGraph){
      final horizontalLineLeft = Offset(chartPadding, y);
      final horizontalLineRight = Offset(xAxisEndPoint.dx, y);
      canvas.drawLine(horizontalLineLeft, horizontalLineRight, graphPainter);
    }
    GraphLinePainter(canvas,height: height,width: width).drawGraph([
      GraphLineCoordinates(0,0),
      GraphLineCoordinates(100,100),
      GraphLineCoordinates(200,250),
      GraphLineCoordinates(300,50),
      GraphLineCoordinates(350,300),
    ]);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
class GraphLinePainter{
  final Canvas canvas;
  final double height;
  final double width;
  final linePainter = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke;

  GraphLinePainter(this.canvas,{required this.height, required this.width});

  void _line({required double x1,required double y1,required double x2,required double y2,}){
    final startPoint = Offset(LineChartPainter.chartPadding+x1, height-LineChartPainter.chartPadding-y1);
    final endPoint = Offset(LineChartPainter.chartPadding+x2, height-LineChartPainter.chartPadding-y2);
    canvas.drawLine(startPoint, endPoint, linePainter);
  }

  void drawGraph(List<GraphLineCoordinates> coordinates){
    List<GraphLineCoordinates> scaledCoords = _scale(coordinates);
    for(int i=0;i<scaledCoords.length-1;i++){
      final startCoordinate = scaledCoords[i];
      final endCoordinate = scaledCoords[i+1];
      _line(x1: startCoordinate.x, y1: startCoordinate.y, x2: endCoordinate.x, y2: endCoordinate.y);
    }
  }
  
  List<GraphLineCoordinates> _scale(List<GraphLineCoordinates> coordinates) {
    double maxY = coordinates.map((e)=>e.y).reduce((a,b)=>max(a,b))..ceil();
    double pixelValueY = ((height-LineChartPainter.chartPadding*2))/maxY;
    return coordinates.map((e)=>GraphLineCoordinates(e.x, e.y*pixelValueY)).toList();
    
  }

}
class GraphLineCoordinates{
  final double x;
  final double y;
  const GraphLineCoordinates(this.x,this.y);
}