// ignore_for_file: camel_case_types

import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';

class Clockview extends StatefulWidget {
  const Clockview({Key? key}) : super(key: key);

  @override
  _clockViewState createState() => _clockViewState();
}

class _clockViewState extends State<Clockview> {
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
        ));
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var cenetrX = size.width /2.5;
    var centerY = size.height / 2.5;
    var center = Offset(cenetrX, centerY);
    var radius = min(cenetrX, centerY);
    var fillBrush = Paint()..color = Color(0xFF444974);

    var outBrush = Paint()
      ..color = Color.fromARGB(255, 141, 140, 138)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    var centerBrush = Paint()..color = Color.fromRGBO(255, 255, 255, 1);

    var secHandBrush = Paint()
      ..color = Color.fromARGB(255, 231, 240, 102)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [
        Color.fromARGB(255, 231, 179, 7),
        Color.fromARGB(255, 255, 3, 3)
      ]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [
        Color.fromARGB(255, 255, 34, 163),
        Color.fromARGB(249, 250, 0, 0)
      ]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7;

    canvas.drawCircle(center, radius - 7, fillBrush);
    canvas.drawCircle(center, radius - 7, outBrush);

    var secHandX = cenetrX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = cenetrX + 80 * sin(dateTime.second * 6 * pi / 180);

    var hourHandX = cenetrX + 60* cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = cenetrX + 60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    var minHandX = cenetrX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = cenetrX + 80 * sin(dateTime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 6, centerBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
