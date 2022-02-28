import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/pages/detailpage/rezept_detail.dart';

// ignore: non_constant_identifier_names
Widget RezeptCard(BuildContext context, Rezept rezept) {
  return Container(
    height: 200,
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
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: rezept.showImage(),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              child: Container(
                padding: const EdgeInsets.only(bottom: 24),
                height: 64,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                              text: rezept.name,
                              style: const TextStyle(
                                  fontSize: 25, color: AppColor.white))),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                                  fontSize: 15, color: AppColor.white))),
                      const Text(
                        ' min',
                        style: TextStyle(color: AppColor.white),
                      ),
                    ],
                  ),
                  Row(
                    children: rezeptBewertung(rezept.bewertung),
                  ),
                ],
              ),
            )
          ],
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
