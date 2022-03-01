import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/sharedDirectory/rezept_card.dart';

class Randompage extends StatefulWidget {
  Rezept? rezept;

  Randompage({Key? key, this.rezept}) : super(key: key);

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
              : RezeptCard(context, widget.rezept!)),
    );
  }
}
