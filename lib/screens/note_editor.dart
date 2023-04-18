import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';
import 'package:intl/intl.dart';

// This pages are use to create a new notes
class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  // Random generate the note colors
  int colour_id = Random().nextInt(AppStyle.cardsColor.length);

  // TextField for title and description, TextEditingController can let the user enter the text
  TextEditingController _titleControlller = TextEditingController();
  TextEditingController _mainControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colour_id],
      appBar: AppBar(
        //AppBar will generated return back icon for navigator push in Flutter
        iconTheme: IconThemeData(color:Colors.white),
        backgroundColor: AppStyle.mainColor,
        elevation: 0.0,
        title: Text("Add a new Note",style: TextStyle(color: Colors.white)),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // Let the user enter the title
              Expanded(
                flex: 0,
                child: TextField(
                  controller: _titleControlller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                  style: AppStyle.mainTitle,
                ),
              ),

              // Show the current date of the system
              Expanded(
                  flex: 0,
                  child: Text(
                      DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
                      style:AppStyle.dateTitle)
              ),

              // Let the user enter the note description
              Expanded(
                flex: 4,
                child: TextField(
                    controller: _mainControlller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Content',
                    ),
                    style: AppStyle.mainContent,
                ),
              ),

            ],
          ),
        ),
      ),

      // Save button, let the user to save the note
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,

          // When user click the button
          onPressed: () async{
            // The information will be store in FireBase
            FirebaseFirestore.instance.collection('Notes').add({
              "note_title":_titleControlller.text,
              "create_date":DateTime.now(),
              "note_content":_mainControlller.text,
              "colour_id":colour_id,
            }).then((value){
              // The system will print the note id in the console and pop out to the home page
              print(value.id);
              Navigator.pop(context);
            }).catchError((error) =>
                // Print the error for why it doesn't save to firebase
                print("Failed t add new note due to $error"));
          },
          child:Icon(Icons.save),
      )
    );
  }

}
