import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';
import 'package:kochbuchapp/provider/provider_rezept.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
Widget DeleteAlertDialog(BuildContext context, Rezept rezept) {
  return AlertDialog(
    title: const Text('Rezept loeschen?'),
    content: Text('Willst du ${rezept.name} wirklich loeschen?'),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context, 'Nein');
          },
          child: const Text('Nein')),
      TextButton(
          onPressed: () {
            Provider.of<ProviderRezept>(context, listen: false)
                .dbloeschenRezeptdata(r: rezept);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Navigatorpage()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text('Ja')),
    ],
  );
}
