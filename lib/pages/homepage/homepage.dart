import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/sharedWidgets/rezept_card.dart';
import 'package:localstore/localstore.dart';
import 'package:kochbuchapp/sharedWidgets/alert_dialog.dart';

class Homepage extends StatefulWidget {
  final Localstore db;
  const Homepage({required this.db, Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Rezept testrezept = Rezept(
      name: 'testrezept',
      dauer: 15,
      bewertung: 3,
      zutaten: ['mehl', 'wasser'],
      beschreibung: 'Nichts');

  List<Rezept> dbrezeptliste = [];

  @override
  void initState() {
    dbGetRezeptData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Homepage oldWidget) {
    dbGetRezeptData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Homepage'),
        ),
        body: GridView.builder(
            shrinkWrap: true,
            itemCount: dbrezeptliste.isEmpty ? 0 : dbrezeptliste.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            DeleteAlertDialog(context, dbrezeptliste[index]),
                        barrierDismissible: false,
                      );
                    });
                  },
                  child: RezeptCard(context, dbrezeptliste[index]));
            }));
  }

  Future<void> dbGetRezeptData() async {
    final documents = await widget.db.collection('alleRezepte').get();
    if (documents != null) {
      dbrezeptliste =
          documents.entries.map((entry) => Rezept.fromMapEntry(entry)).toList();
      setState(() {});
    }
  }

  void dbAddRezeptdata(Rezept r) {
    r.saveRezept();
    dbGetRezeptData();
  }
}
