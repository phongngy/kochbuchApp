import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';

Widget beschreibung(Rezept _rezept) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: RichText(
              text: const TextSpan(
                  text: 'Beschreibung',
                  style: TextStyle(fontSize: 25, color: Colors.black))),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(_rezept.beschreibung.isEmpty
                ? 'Keine Beschreibung vorhanden'
                : _rezept.beschreibung),
          ),
        ),
      ],
    ),
  );
}
