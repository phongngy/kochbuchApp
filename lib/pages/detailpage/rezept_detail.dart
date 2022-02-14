import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/sharedWidgets/rezept_card.dart';
import 'package:kochbuchapp/pages/detailpage/rezept_edit.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';

class Rezeptdetail extends StatelessWidget {
  Rezept _rezept;
  Rezeptdetail(Rezept this._rezept, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_rezept.name),
        //TODO: edit-Funktion oben
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RezeptEditPage(
                      db: getItInjector<Localstore>(),
                      rezept: _rezept,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          Container(color: Colors.red, width: double.infinity, height: 200),
          RichText(
              maxLines: 2,
              text: TextSpan(
                  text: _rezept.name,
                  style: TextStyle(fontSize: 25, color: Colors.black))),
          Row(
            children: [
              const Icon(Icons.alarm),
              RichText(
                  text: TextSpan(
                      text: _rezept.dauer.toString(),
                      style: TextStyle(fontSize: 15, color: Colors.black))),
              const Text(' min'),
              Expanded(
                child: Row(
                  children: RezeptBewertung(_rezept.bewertung),
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1.5),
          RichText(
              text: TextSpan(
                  text: 'Beschreibung',
                  style: TextStyle(fontSize: 25, color: Colors.black))),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(_rezept.beschreibung ?? 'Keine Beschreibung vorhanden'),
          ),
        ],
      ),
    );
  }
}
