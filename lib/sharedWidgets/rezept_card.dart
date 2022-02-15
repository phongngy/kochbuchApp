import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/pages/detailpage/rezept_detail.dart';

// ignore: non_constant_identifier_names
Widget RezeptCard(BuildContext context, Rezept rezept) {
  return Card(
    child: InkWell(
        onTap: () {
          //TODO: Hero-Animation einfügen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Rezeptdetail(rezept)),
          );
        },
        child: Column(
          children: [
            //TODO: Bild statt platzhalter
            SizedBox(
              child: Container(color: Colors.red),
              width: double.infinity,
              height: 100,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                        text: rezept.name,
                        style: const TextStyle(
                            fontSize: 25, color: Colors.black))),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.alarm),
                RichText(
                    text: TextSpan(
                        text: rezept.dauer.toString(),
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black))),
                const Text(' min'),
                Flexible(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      children: rezeptBewertung(rezept.bewertung),
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
  );
}

List<Widget> rezeptBewertung(int bewertung) {
  final gefuellteSterne = List<Widget>.filled(5, Container());

  for (int i = 0; i < bewertung; i++) {
    gefuellteSterne[i] = const Icon(
      Icons.star_rate_sharp,
      color: Colors.yellow,
    );
  }
  for (int i = bewertung; i < 5; i++) {
    gefuellteSterne[i] = const Icon(
      Icons.star_rate_sharp,
      color: Colors.grey,
    );
  }

  return gefuellteSterne;
}
