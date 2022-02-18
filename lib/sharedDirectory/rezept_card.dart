import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/pages/detailpage/rezept_detail.dart';

// ignore: non_constant_identifier_names
Widget RezeptCard(BuildContext context, Rezept rezept) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.black12,
          blurRadius: 35,
          spreadRadius: 0,
          offset: Offset.fromDirection(-0.5, 15))
    ]),
    child: Card(
      child: InkWell(
        onTap: () {
          //TODO: Hero-Animation einfügen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Rezeptdetail(rezept)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //TODO: Bild statt platzhalter
              SizedBox(
                child: Container(color: Colors.red),
                width: double.infinity,
                height: 100,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: TextSpan(
                          text: rezept.name,
                          style: const TextStyle(
                              fontSize: 25, color: Colors.black))),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.alarm,
                    color: AppColor.primary,
                  ),
                  RichText(
                      text: TextSpan(
                          text: rezept.dauer.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black))),
                  const Text(' min'),
                  Flexible(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        children: rezeptBewertung(rezept.bewertung),
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

List<Widget> rezeptBewertung(int bewertung) {
  final gefuellteSterne = List<Widget>.filled(5, Container());

  for (int i = 0; i < bewertung; i++) {
    gefuellteSterne[i] = const Icon(
      Icons.star_rate_sharp,
      color: Colors.yellow,
    );
  }
  for (int i = bewertung; i < 5; i++) {
    gefuellteSterne[i] = const Icon(
      Icons.star_rate_sharp,
      color: Colors.grey,
    );
  }

  return gefuellteSterne;
}