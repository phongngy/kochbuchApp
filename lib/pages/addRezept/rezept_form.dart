import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';

class RezeptForm extends StatefulWidget {
  const RezeptForm({Key? key}) : super(key: key);

  @override
  State<RezeptForm> createState() => _RezeptFormState();
}

class _RezeptFormState extends State<RezeptForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var nameCtrl = TextEditingController();
  var dauerCtrl = TextEditingController();
  var bewertungCtrl = TextEditingController();
  var zutatenCtrl = TextEditingController();
  var beschreibungCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      (Rezept(
                              name: nameCtrl.text,
                              dauer: int.parse(dauerCtrl.text),
                              bewertung: int.parse(bewertungCtrl.text),
                              zutaten: zutatenListeErstellen(zutatenCtrl.text),
                              beschreibung: beschreibungCtrl.text))
                          .saveRezept();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Navigatorpage()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text('Hinzufuegen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> zutatenListeErstellen(String zutaten) {
    return zutaten.replaceAll(' ', '').split(',');
  }
}
