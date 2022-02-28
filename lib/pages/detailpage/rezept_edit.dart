import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';
import 'package:localstore/localstore.dart';

class RezeptEditPage extends StatefulWidget {
  Rezept rezept;

  Localstore db;
  RezeptEditPage({required this.rezept, required this.db, Key? key})
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
  final _picker = getItInjector<ImagePicker>();
  late Localstore db;

  @override
  void dispose() {
    nameCtrl.dispose();
    dauerCtrl.dispose();
    bewertungCtrl.dispose();
    zutatenCtrl.dispose();
    beschreibungCtrl.dispose();
    super.dispose();
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
    beschreibungCtrl.text = widget.rezept.beschreibung;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezept bearbeiten'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    picker();
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primary),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: widget.rezept.showImage(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Rezeptname',
                        contentPadding: EdgeInsets.all(8),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Feld bitte ausfuellen';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
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
                          textInputAction: TextInputAction.next,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.db
                            .collection('alleRezepte')
                            .doc(widget.rezept.id)
                            .set(Rezept(
                                    name: nameCtrl.text,
                                    dauer: int.parse(dauerCtrl.text),
                                    bewertung: int.parse(bewertungCtrl.text),
                                    zutaten:
                                        zutatenListeErstellen(zutatenCtrl.text),
                                    beschreibung: beschreibungCtrl.text,
                                    image: widget.rezept.image)
                                .toMap());
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
    return zutaten.split(',');
  }

  Future<void> picker() async {
    try {
      final chooseimage = await _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 363.4);
      if (chooseimage == null) return;

      widget.rezept.image = base64Encode(await chooseimage.readAsBytes());
      setState(() {});
    } on PlatformException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery Zugriff verhindert')),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Etwas ist schief gelaufen: $e')),
      );
    }
  }
}
