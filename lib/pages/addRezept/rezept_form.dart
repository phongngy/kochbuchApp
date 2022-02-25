import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kochbuchapp/classes/rezept.dart';
import 'package:kochbuchapp/fixValues/appcolors.dart';
import 'package:kochbuchapp/getit/injector.dart';
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';
import 'package:localstore/localstore.dart';

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
  final _picker = getItInjector<ImagePicker>();
  late var db;
  String _imagepath = '';
  String _imagedata = '';

  bool _emptyimage = true;

  bool _imageset = false;

  @override
  void dispose() {
    _emptyimage = true;
    _imageset = false;
    _imagepath = '';
    _imagedata = '';
    nameCtrl.dispose();
    dauerCtrl.dispose();
    bewertungCtrl.dispose();
    zutatenCtrl.dispose();
    beschreibungCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    db = getItInjector<Localstore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: _imagepath.isEmpty
                          ? const Icon(
                              Icons.photo,
                              color: AppColor.secondary,
                              size: 75,
                            )
                          : Image.file(File(_imagepath))),
                ),
              ),
              Row(
                children: [
                  _emptyimage
                      ? _imageset
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Bild bitte aussuchen',
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : Container()
                      : Container()
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 40,
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
                      if (_imagedata.isEmpty) {
                        setState(() {
                          _imageset = true;
                        });
                      } else {
                        (Rezept(
                                name: nameCtrl.text,
                                dauer: int.parse(dauerCtrl.text),
                                bewertung: int.parse(bewertungCtrl.text),
                                zutaten:
                                    zutatenListeErstellen(zutatenCtrl.text),
                                beschreibung: beschreibungCtrl.text,
                                image: _imagedata))
                            .saveRezept();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navigatorpage()),
                          (Route<dynamic> route) => false,
                        );
                      }
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
    return zutaten.split(',');
  }

  Future<void> picker() async {
    try {
      final chooseimage = await _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 363.4);
      if (chooseimage == null) return;

      _imagedata = base64Encode(await chooseimage.readAsBytes());
      setState(() {
        _emptyimage = false;
        _imagepath = chooseimage.path;
      });
    } on PlatformException catch (pe) {
      print(pe);
    } on Exception catch (e) {
      print(e);
    }
  }
}
