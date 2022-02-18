import 'package:flutter/material.dart';

Widget GlowCard({required Color color, required Widget child}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(blurRadius: 75, color: color.withAlpha(175), spreadRadius: -10)
    ]),
    child: Card(
      color: color,
      margin: const EdgeInsets.only(left: 32, right: 32),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: child),
      ),
    ),
  );
}
