import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/sharedDirectory/alert_dialog.dart';
import 'package:kochbuchapp/sharedDirectory/glow_card.dart';
import 'package:kochbuchapp/sharedDirectory/rezept_card.dart';
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
          Row(
            children: [
              SizedBox(
                height: 175,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 32, left: 24, top: 8, bottom: 8),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: RichText(
                        maxLines: 3,
                        text: TextSpan(
                            text: _rezept.name,
                            style: const TextStyle(
                                fontSize: 25, color: AppColor.secondary))),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                height: 175,
                decoration: const BoxDecoration(
                    color: AppColor.primary,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(64))),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.alarm,
                  color: AppColor.secondary,
                ),
                RichText(
                    text: TextSpan(
                        text: _rezept.dauer.toString(),
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black))),
                const Text(' min'),
                Expanded(
                  child: Row(
                    children: rezeptBewertung(_rezept.bewertung),
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColor.secondary,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RichText(
                text: const TextSpan(
                    text: 'Zutaten',
                    style: TextStyle(fontSize: 25, color: Colors.black))),
          ),
          zutatenListeUI(_rezept),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(
              color: AppColor.secondary,
              thickness: 1,
              indent: 32,
              endIndent: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RichText(
                text: const TextSpan(
                    text: 'Beschreibung',
                    style: TextStyle(fontSize: 25, color: Colors.black))),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GlowCard(
                color: AppColor.primary,
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(_rezept.beschreibung.isEmpty
                        ? 'Keine Beschreibung vorhanden'
                        : _rezept.beschreibung),
                  ),
                ),
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
          children: [
            Text(
              '$counter. $rezept',
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      );
      uiList.add(const SizedBox(height: 5.0));
    }

    return Flexible(
        flex: 2,
        child:
            GlowCard(color: AppColor.primary, child: Column(children: uiList)));
  }
}
