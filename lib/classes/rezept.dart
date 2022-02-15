import 'package:flutter/foundation.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';

class Rezept {
  String? id;
  String name;
  int dauer;
  int bewertung;
  List<String> zutaten;
  String? beschreibung;
  Rezept({
    this.id,
    required this.name,
    required this.dauer,
    required this.bewertung,
    required this.zutaten,
    this.beschreibung,
  });

  Rezept copyWith({
    String? name,
    int? dauer,
    int? bewertung,
    List<String>? zutaten,
    String? beschreibung,
  }) {
    return Rezept(
      name: name ?? this.name,
      dauer: dauer ?? this.dauer,
      bewertung: bewertung ?? this.bewertung,
      zutaten: zutaten ?? this.zutaten,
      beschreibung: beschreibung ?? this.beschreibung,
    );
  }

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
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rezept &&
        other.name == name &&
        other.dauer == dauer &&
        other.bewertung == bewertung &&
        listEquals(other.zutaten, zutaten) &&
        other.beschreibung == beschreibung;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        dauer.hashCode ^
        bewertung.hashCode ^
        zutaten.hashCode ^
        beschreibung.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dauer': dauer,
      'bewertung': bewertung,
      'zutaten': zutaten,
      'beschreibung': beschreibung,
    };
  }

  @override
  String toString() {
    return 'Rezept(id: $id, name: $name, dauer: $dauer, bewertung: $bewertung, zutaten: $zutaten, beschreibung: $beschreibung)';
  }
}

extension ManipulateRezeptData on Rezept {
  void saveRezept() {
    final _db = getItInjector<Localstore>();
    _db.collection('alleRezepte').doc(id).set(toMap());
    print('Rezept $name locally gesaved');
  }

  void deleteRezept() {
    final _db = getItInjector<Localstore>();
    _db.collection('alleRezepte').doc(id).delete();
    print('Rezept $name locally deleted');
  }
}
