import 'package:flutter/material.dart';
import 'package:kochbuchapp/pages/addRezept/rezept_form.dart';

class AddRezept extends StatelessWidget {
  const AddRezept(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezept hinzufuegen'),
      ),
      body: RezeptForm(),
    );
  }
}
