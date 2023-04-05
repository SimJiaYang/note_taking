import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleControlller = TextEditingController();
    _titleControlller .text = widget.doc["note_title"];
    TextEditingController _mainControlller = TextEditingController();
    _mainControlller.text = widget.doc["note_content"];

    String date = DateTime.now().toString();
    String docID = widget.doc.id; //not need to add noteid inside the table
    int color_id = widget.doc["colour_id"];
    Color colour = AppStyle.cardsColor[color_id];

    return Scaffold(
      backgroundColor: colour,
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        elevation: 0.0,
      ),
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(
              flex: 1,
              child: TextField(
                controller: _titleControlller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: AppStyle.mainTitle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            

            Expanded(
                flex: 1,
                child: Text(widget.doc["create_date"],style: AppStyle.dateTitle,)
            ),

            Expanded(
              flex: 4,
              child: TextField(
                controller: _mainControlller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
              
              //overflow: TextOverflow.ellipsis,
          ], //Children
        ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,
          onPressed: () async{
            print(docID);
            FirebaseFirestore.instance.collection('Notes').doc(docID).update({
              "note_title":_titleControlller.text,
              "create_date":date,
              "note_content":_mainControlller.text,
              "colour_id": color_id,
            }).then((result){
              print('Update successfully');
              Navigator.pop(context);
            }).catchError((error) =>
                print("Failed to add new note due to $error"));
          },
          child:Icon(Icons.save),
        )
    );
  }
}
