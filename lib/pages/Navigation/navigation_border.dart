import 'package:flutter/material.dart';

class MyBorderShape extends NotchedShape {
  MyBorderShape();

  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  double holeSize = 70;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(RRect.fromRectAndCorners(
          host,
          topLeft: const Radius.circular(25),
          topRight: const Radius.circular(25),
        ))
        ..close(),
      Path()
        ..addOval(Rect.fromCenter(
            center: host.center.translate(0, -host.height / 2),
            height: holeSize,
            width: holeSize))
        ..close(),
    );
  }

  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
