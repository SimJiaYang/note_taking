import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int colour_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
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
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextField(
                controller: _titleControlller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
                style: AppStyle.mainTitle,
              ),
            ),

            Expanded(
                flex: 1,
                child: Text(date,style:AppStyle.dateTitle)
            ),
              
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
          onPressed: () async{
            FirebaseFirestore.instance.collection('Notes').add({
              "note_title":_titleControlller.text,
              "create_date":date,
              "note_content":_mainControlller.text,
              "colour_id":colour_id,
            }).then((value){
              print(value.id);
              Navigator.pop(context);
            }).catchError((error) =>
                print("Failed t add new note due to $error"));
          },
          child:Icon(Icons.save),
      )
    );
  }
}
