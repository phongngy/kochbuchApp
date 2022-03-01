import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/pages/detailpage/rezept_beschreibung.dart';
import 'package:kochbuchapp/pages/detailpage/zutaten_liste.dart';
import 'package:kochbuchapp/sharedDirectory/alert_dialog.dart';
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
        title: const Text('Details'),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColor.secondary),
              child: Hero(tag: _rezept.id!, child: _rezept.showImage()),
              width: double.infinity,
              height: 200,
            ),
          ),
          RichText(
              maxLines: 3,
              text: TextSpan(
                  text: _rezept.name,
                  style: const TextStyle(
                      fontSize: 25, color: AppColor.secondary))),
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
          DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: [
                    const TabBar(
                      indicatorColor: AppColor.secondary,
                      tabs: <Widget>[
                        Tab(
                          child: Text('Zutaten'),
                        ),
                        Tab(
                          child: Text('Beschreibung'),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBarView(children: [
                          zutatenListeUI(_rezept),
                          beschreibung(_rezept),
                        ]),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
