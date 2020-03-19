import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/root_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityApp',
      theme:
          ThemeData(
              primarySwatch: Colors.green,
              accentColor: Colors.white,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .copyWith(
                          headline: GoogleFonts.poppins(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          display1: GoogleFonts.poppins(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          subhead: GoogleFonts.poppins(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          display2: GoogleFonts.poppins(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          display3: GoogleFonts.poppins(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
      home: RootPage(),
    );
  }
}
