import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groupalike/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GroupAlike App',
      // color: Color(0xFF0BA9B3),
      theme: ThemeData(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        primaryColor: Colors.white,
        accentColor: Color(0xFF0BA9B3),
        backgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0BA9B3),
          secondary: Color(0xFFB4B4B4),
          background: Colors.white,
        ),
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Color(0xFF0BA9B3),
          displayColor: Color(0xFF0BA9B3),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          textTheme: Theme.of(context).textTheme,
        ),
      ),
      home: MainScreen(),
    );
  }
}
