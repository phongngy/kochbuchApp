import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';

class Rezept {
  String? id;
  String name;
  int dauer;
  int bewertung;
  List<String> zutaten;
  String beschreibung;
  String image;
  Rezept({
    this.id,
    required this.name,
    required this.dauer,
    required this.bewertung,
    required this.zutaten,
    this.beschreibung = '',
    this.image = '',
  });

  factory Rezept.fromMapEntry(MapEntry<String, dynamic> entry) {
    return Rezept(
        id: entry.key.substring(
            entry.key.substring(entry.key.indexOf('/') + 1).indexOf('/') +
                2), // +2 weil 2. Argument von substring exklusiv
        name: entry.value['name'] ?? '',
        dauer: entry.value['dauer'] ?? 0,
        bewertung: entry.value['bewertung'] ?? 0,
        zutaten: (entry.value['zutaten'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        beschreibung: entry.value['beschreibung'],
        image: entry.value['image']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dauer': dauer,
      'bewertung': bewertung,
      'zutaten': zutaten,
      'beschreibung': beschreibung,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Rezept(id: $id, name: $name, dauer: $dauer, bewertung: $bewertung, zutaten: $zutaten, beschreibung: $beschreibung, image: $image)';
  }

  Image showImage() {
    return Image.memory(base64Decode(image));
  }
}

extension ManipulateRezeptData on Rezept {
  void saveRezept() {
    final _db = getItInjector<Localstore>();
    _db.collection('alleRezepte').doc(id).set(toMap());
  }

  void deleteRezept() {
    final _db = getItInjector<Localstore>();
    _db.collection('alleRezepte').doc(id).delete();
  }
}
