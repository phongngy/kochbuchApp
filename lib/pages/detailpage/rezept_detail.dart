import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/sharedWidgets/alert_dialog.dart';
import 'package:kochbuchapp/sharedWidgets/rezept_card.dart';
import 'package:kochbuchapp/pages/detailpage/rezept_edit.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';

class Rezeptdetail extends StatelessWidget {
  final Rezept _rezept;
  const Rezeptdetail(this._rezept, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_rezept.name),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteAlertDialog(context, _rezept),
                barrierDismissible: false,
              );
            },
            icon: const Icon(Icons.delete),
          ),
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
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(color: Colors.red, width: double.infinity, height: 200),
          RichText(
              maxLines: 2,
              text: TextSpan(
                  text: _rezept.name,
                  style: const TextStyle(fontSize: 25, color: Colors.black))),
          Row(
            children: [
              const Icon(Icons.alarm),
              RichText(
                  text: TextSpan(
                      text: _rezept.dauer.toString(),
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black))),
              const Text(' min'),
              Expanded(
                child: Row(
                  children: rezeptBewertung(_rezept.bewertung),
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1.5),
          zutatenListeUI(_rezept),
          const Divider(thickness: 1.5),
          RichText(
              text: const TextSpan(
                  text: 'Beschreibung',
                  style: TextStyle(fontSize: 25, color: Colors.black))),
          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_rezept.beschreibung.isEmpty
                    ? 'Keine Beschreibung vorhanden'
                    : _rezept.beschreibung),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget zutatenListeUI(Rezept rezept) {
    var uiList = <Widget>[];
    int counter = 0;
    for (var rezept in rezept.zutaten) {
      counter++;
      uiList.add(
        Row(
          children: [Text('$counter. '), Text(rezept)],
        ),
      );
      uiList.add(const SizedBox(height: 5.0));
    }

    return Flexible(
        flex: 3, child: SingleChildScrollView(child: Column(children: uiList)));
  }
}
