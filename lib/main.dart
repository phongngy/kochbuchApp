import 'package:flutter/material.dart';
import 'package:kochbuchapp/fixValues/apptheme.dart';

import 'package:kochbuchapp/getit/injector.dart' as injector;
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const SafeArea(child: Navigatorpage()),
    );
  }
}
