import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/pages/homepage/homepage.dart';
import 'package:kochbuchapp/pages/random/random.dart';
import 'package:kochbuchapp/pages/Navigation/navigation_border.dart';
import 'package:kochbuchapp/pages/addRezept/add_rezept.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';
import 'dart:math';

class Navigatorpage extends StatefulWidget {
  const Navigatorpage({Key? key}) : super(key: key);

  @override
  _NavigatorpageState createState() => _NavigatorpageState();
}

class _NavigatorpageState extends State<Navigatorpage> {
  final PageController _pageController = PageController(initialPage: 0);
  bool _startindex = true;
  final db = getItInjector<Localstore>();
  var random = Random();
  List<Rezept> dbrezeptliste = [];

  Rezept? zufaelligesRezept;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              if (newIndex == 0) {
                _startindex = true;
              } else {
                _startindex = false;
              }
            });
          },
          children: [
            Homepage(
              db: getItInjector<Localstore>(),
            ),
            Randompage(rezept: zufaelligesRezept),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: MyBorderShape(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  color: _startindex ? AppColor.secondary : AppColor.white,
                  icon: const Icon(
                    Icons.list_alt_rounded,
                  ),
                  onPressed: () {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }),
              IconButton(
                color: !_startindex ? AppColor.secondary : AppColor.white,
                icon: const Icon(
                  Icons.contact_support,
                ),
                onPressed: () {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: _startindex
            ? FloatingActionButton(
                tooltip: 'Hinzufuegen',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRezept(context),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              )
            : FloatingActionButton(
                tooltip: 'Rezept generieren',
                onPressed: () async {
                  try {
                    zufaelligesRezept = await rezeptgenerieren();
                    setState(() {});
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.secondary,
                        content: Text(e.toString())));
                  }
                },
                child: const Icon(Icons.wifi_protected_setup),
              ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Future<Rezept> rezeptgenerieren() async {
    final documents = await db.collection('alleRezepte').get();
    if (documents != null) {
      dbrezeptliste =
          documents.entries.map((entry) => Rezept.fromMapEntry(entry)).toList();
      return dbrezeptliste[random.nextInt(dbrezeptliste.length)];
    } else {
      throw Exception('Keine Rezepte vorhanden');
    }
  }
}
