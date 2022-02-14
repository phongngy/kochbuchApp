import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';
import 'package:localstore/localstore.dart';
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';

class RezeptEditPage extends StatefulWidget {
  Rezept rezept;

  Localstore db;
  RezeptEditPage({required Rezept this.rezept, required this.db, Key? key})
      : super(key: key);

  @override
  _RezeptEditPageState createState() => _RezeptEditPageState();
}

class _RezeptEditPageState extends State<RezeptEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var nameCtrl = TextEditingController();
  var dauerCtrl = TextEditingController();
  var bewertungCtrl = TextEditingController();
  var zutatenCtrl = TextEditingController();
  var beschreibungCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameCtrl.text = widget.rezept.name;
    dauerCtrl.text = widget.rezept.dauer.toString();
    bewertungCtrl.text = widget.rezept.bewertung.toString();
    zutatenCtrl.text = widget.rezept.zutaten
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '');
    beschreibungCtrl.text = widget.rezept.beschreibung ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezept bearbeiten'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Rezeptname',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Feld bitte ausfuellen';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: dauerCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Dauer in min',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Feld bitte ausfuellen';
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: bewertungCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Rezept bewerten',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Feld bitte ausfuellen';
                          }
                          if (int.parse(value) > 5) {
                            return 'Bewertung nur bis 5';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: zutatenCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Zutaten mit ,-getrennt eingeben',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Feld bitte ausfuellen';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: beschreibungCtrl,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Rezepbeschreibung',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Rezeptgeaendert();
                        widget.db
                            .collection('alleRezepte')
                            .doc(widget.rezept.id)
                            .set(widget.rezept.toMap());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navigatorpage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: const Text('Bearbeiten'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> zutatenListeErstellen(String zutaten) {
    return zutaten.replaceAll(' ', '').split(',');
  }

  void Rezeptgeaendert() {
    if (nameCtrl.text != widget.rezept.name) {
      widget.rezept.name = nameCtrl.text;
    }
    if (int.parse(dauerCtrl.text) != widget.rezept.dauer) {
      widget.rezept.dauer = int.parse(dauerCtrl.text);
    }
    if (int.parse(bewertungCtrl.text) != widget.rezept.bewertung) {
      widget.rezept.bewertung = int.parse(bewertungCtrl.text);
    }
    if (zutatenCtrl.text != widget.rezept.zutaten.toString()) {
      widget.rezept.zutaten = zutatenListeErstellen(zutatenCtrl.text);
    }
    if (beschreibungCtrl.text != widget.rezept.beschreibung) {
      widget.rezept.beschreibung = beschreibungCtrl.text;
    }
  }
}