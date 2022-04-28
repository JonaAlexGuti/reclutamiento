import 'package:flutter/material.dart';
import 'package:reclutamiento/vistas/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: NavigationHomeScreen(),
    );
  }
}

