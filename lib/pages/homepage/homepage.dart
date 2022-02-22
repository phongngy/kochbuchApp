import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/sharedDirectory/rezept_card.dart';
import 'package:localstore/localstore.dart';
import 'package:kochbuchapp/sharedDirectory/alert_dialog.dart';

class Homepage extends StatefulWidget {
  final Localstore db;
  const Homepage({required this.db, Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxisScrolled) =>
            [const SliverAppBar(title: Text('Rezeptliste'))],
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemCount: dbrezeptliste.isEmpty ? 0 : dbrezeptliste.length,
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
            }),
      ),
    );
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
