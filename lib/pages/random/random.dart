import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/sharedDirectory/rezept_card.dart';

class Randompage extends StatefulWidget {
  Rezept? rezept;

  double height;

  double width;

  Randompage({Key? key, this.rezept, required this.height, required this.width})
      : super(key: key);

  @override
  State<Randompage> createState() => _RandompageState();
}

class _RandompageState extends State<Randompage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zufaelliges Rezept'),
      ),
      body: Center(
          child: widget.rezept == null
              ? Container()
              : AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutSine,
                  child: SizedBox(
                      height: widget.height,
                      width: widget.width,
                      child: RezeptCard(context, widget.rezept!)))),
    );
  }
}
