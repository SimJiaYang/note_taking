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
  TextEditingController _titleControlller = TextEditingController();
  TextEditingController _mainControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          children: [

            Text(widget.doc["note_title"],style: AppStyle.mainTitle,),
              SizedBox(height: 4.0),
            Text(widget.doc["create_date"],style: AppStyle.dateTitle,),
              SizedBox(height: 28.0),
            Text(
              widget.doc["note_content"],style:
              AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
            
          ], //Children
    ),
        ),
      ),
    );
  }
}
