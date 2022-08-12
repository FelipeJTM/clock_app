import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}
class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //360 sec - 360, 1 sec - 6 degree

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;

    //define the center of the circle
    var center = Offset(centerX, centerY);
    //define the radius of the circle
    var radius = min(centerX, centerY);
    //fill brush red
    var fillBrush = Paint()
      ..color = Color(0xffBD4B4B);
    //outline brush
    var outlineBrush = Paint()
      ..color = Color(0xffEEEEEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;
    //center fill brush
    var centerFillBrush = Paint()
      ..color = Color(0xffEEEEEE);

    //seconds hand brush
    var secondHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Color(0xffEFB7B7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    //min hand brush
    var minHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader = RadialGradient(colors: [Color(0xffffc800), Color(0xff0be059)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    //hour hand brush
    var hourHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader = RadialGradient(colors: [Color(0xff0b53e0), Color(0xffd900ff)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    //draw the actual circle:
    canvas.drawCircle(center, radius - 40, outlineBrush);
    canvas.drawCircle(center, radius - 40, fillBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        80 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}