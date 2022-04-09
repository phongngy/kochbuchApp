import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';

class ProviderRezept extends ChangeNotifier {
  List<Rezept> dbrezeptliste = [];
  Localstore db = getItInjector<Localstore>();

  Future<void> dbGetRezeptData() async {
    final documents = await db.collection('alleRezepte').get();
    if (documents != null) {
      dbrezeptliste =
          documents.entries.map((entry) => Rezept.fromMapEntry(entry)).toList();
      notifyListeners();
    }
  }

  void dbAddRezeptdata(Rezept r) {
    r.saveRezept();
    dbGetRezeptData();
  }

  void dbBearbeitenRezeptdata(
      {required Rezept r,
      required String name,
      required int dauer,
      required int bewertung,
      required String zutaten,
      required String beschreibung,
      required String image}) {
    db.collection('alleRezepte').doc(r.id).set(Rezept(
            name: name,
            dauer: dauer,
            bewertung: bewertung,
            zutaten: zutatenListeErstellen(zutaten),
            beschreibung: beschreibung,
            image: image)
        .toMap());
    dbGetRezeptData();
  }

  List<String> zutatenListeErstellen(String zutaten) {
    return zutaten.split(',');
  }

  void dbloeschenRezeptdata({required Rezept r}) {
    r.deleteRezept();
    dbGetRezeptData();
  }

  Future<Rezept> rezeptgenerieren() async {
    final documents = await db.collection('alleRezepte').get();
    if (documents != null) {
      dbrezeptliste =
          documents.entries.map((entry) => Rezept.fromMapEntry(entry)).toList();
      notifyListeners();
      return dbrezeptliste[Random().nextInt(dbrezeptliste.length)];
    } else {
      throw Exception('Keine Rezepte vorhanden');
    }
  }
}
