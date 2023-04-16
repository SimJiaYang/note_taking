import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? searchNotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Search Notes"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: AppStyle.kTextFieldInputDecoration,
                onChanged: (String noteValue){
                  searchNotes = noteValue;
                },
              ),
            ),
                TextButton(
                  onPressed: () {
                  Navigator.pop(context,searchNotes);},
                    child: Text(
                      'Get Note',
                      style: AppStyle.kButtonTextStyle,
                    ),
                ),
              ], //Children
        ),
      ),
    );
  }
}

