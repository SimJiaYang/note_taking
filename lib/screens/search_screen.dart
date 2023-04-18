import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';

// The screen that let the user search the notes
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

              // A text field to let the user enter the search content
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: AppStyle.kTextFieldInputDecoration,
                onChanged: (String noteValue){
                  searchNotes = noteValue;
                },
              ),
            ),

                // After the user enter the text, let the user click the search button
                TextButton(
                  onPressed: () {
                  // Pop up the current screen and return the search context
                  Navigator.pop(context,searchNotes);},
                    child: Text(
                      'Search',
                      style: AppStyle.kButtonTextStyle,
                    ),
                ),
              ], //Children
        ),
      ),
    );
  }
}

