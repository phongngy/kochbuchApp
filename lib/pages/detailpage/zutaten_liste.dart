import 'package:flutter/material.dart';
import 'package:kochbuchapp/classes/rezept.dart';

Widget zutatenListeUI(Rezept rezept) {
  var uiList = <DataRow>[];
  int counter = 0;
  for (var zutat in rezept.zutaten) {
    counter++;
    uiList.add(
      DataRow(
        cells: [DataCell(Text('$counter. ')), DataCell(Text(zutat))],
      ),
    );
  }

  return SingleChildScrollView(
    child: DataTable(
      columns: const [
        DataColumn(
            label: Text(
          'Nr.',
        )),
        DataColumn(label: Text('Zutaten')),
      ],
      rows: uiList,
    ),
  );
}
