import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';
import 'package:quickalert/quickalert.dart';
import 'package:intl/intl.dart';

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

    String docID = widget.doc.id; //not need to add noteid inside the table
    int color_id = widget.doc["colour_id"];
    Color colour = AppStyle.cardsColor[color_id];

    return Scaffold(
      backgroundColor: colour,

        appBar: AppBar(
          backgroundColor: AppStyle.mainColor,
          title: const Text('Note'),
          actions: <Widget>[

            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Are you confirm to delete this note?',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.red,

                  onConfirmBtnTap: () async {
                    await FirebaseFirestore.instance.
                        collection("Notes")
                        .doc(docID)
                        .delete()
                        .then((_) => print('Deleted'))
                        .catchError((error) => print('Delete failed: $error'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                  );

              },
            ),
          ],
        ),


      //   elevation: 0.0,
      // ),
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(
              flex: 0,
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
                flex:0,

                child: Text(
                  timestampToDateString(widget.doc["create_date"]),
                  style: AppStyle.dateTitle,)
            ),

            Expanded(
              flex: 4,
              child: TextField(
                textAlign:TextAlign.justify,
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
              "create_date":DateTime.now(),
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
  // Convert Firebase timestamp to Flutter date format
  String timestampToDateString(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
    return formattedDate;
  }
}
