import 'package:flutter/material.dart';
import 'package:kochbuchapp/pages/homepage/homepage.dart';
import 'package:kochbuchapp/pages/random/random.dart';
import 'package:kochbuchapp/pages/Navigation/navigation_border.dart';
import 'package:kochbuchapp/pages/addRezept/add_rezept.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:localstore/localstore.dart';

class Navigatorpage extends StatefulWidget {
  const Navigatorpage({Key? key}) : super(key: key);

  @override
  _NavigatorpageState createState() => _NavigatorpageState();
}

class _NavigatorpageState extends State<Navigatorpage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: hier notched background ändern
        backgroundColor: Colors.red,
        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {});
          },
          children: [
            Homepage(
              db: getItInjector<Localstore>(),
            ),
            const Randompage(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: MyBorderShape(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.list_alt_rounded,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }),
              IconButton(
                icon: const Icon(
                  Icons.contact_support,
                  color: Colors.redAccent,
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
        floatingActionButton: FloatingActionButton(
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
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
