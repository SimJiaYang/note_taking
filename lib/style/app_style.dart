import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static Color bgColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);

  //Setting the color for the card
  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
  ];

  //Setting the text style
  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize:18.0,
    fontWeight:FontWeight.bold,
  );
  static TextStyle mainContent = GoogleFonts.nunito(
    fontSize:16.0,
    fontWeight:FontWeight.normal,
  );
  static TextStyle dateTitle = GoogleFonts.roboto(
    fontSize:13.0,
    fontWeight:FontWeight.w500,
  );

  static TextStyle subTitle = GoogleFonts.roboto(
    fontSize:22.0,
    fontWeight:FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle prompt = GoogleFonts.nunito(
    color: Colors.white,
  );

  static TextStyle test1 = GoogleFonts.nunito(
    color: Colors.black,
  );

  // Set the text field style
  static const kTextFieldInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Enter Note Content',
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide.none,
    ),
  );

  // Set the button style
  static const kButtonTextStyle = TextStyle(
    fontSize: 30.0,
    color: Colors.white,
  );

}