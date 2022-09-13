import 'package:falemais_app_flutter/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.orange)),
        title: 'FaleMais App',
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
