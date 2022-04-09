import 'package:flutter/material.dart';
import 'package:kochbuchapp/fixValues/apptheme.dart';

import 'package:kochbuchapp/getit/injector.dart' as injector;
import 'package:kochbuchapp/pages/Navigation/navigatorpage.dart';
import 'package:kochbuchapp/provider/provider_rezept.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  injector.init();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ProviderRezept())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderRezept>(context, listen: false).dbGetRezeptData();
    return MaterialApp(
      theme: AppTheme.theme,
      home: const SafeArea(child: Navigatorpage()),
    );
  }
}
