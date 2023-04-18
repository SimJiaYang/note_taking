import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';
import 'package:quickalert/quickalert.dart';
import 'package:intl/intl.dart';

// User can edit and update --- delete their note since their click the note from home page
class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {

  @override
  Widget build(BuildContext context) {
    // Show the note title and content that user selected and let th user edit it
    TextEditingController _titleControlller = TextEditingController();
    _titleControlller .text = widget.doc["note_title"];
    TextEditingController _mainControlller = TextEditingController();
    _mainControlller.text = widget.doc["note_content"];

    // Get the current note information
    String docID = widget.doc.id;
    int color_id = widget.doc["colour_id"];
    Color colour = AppStyle.cardsColor[color_id];

    return Scaffold(
      backgroundColor: colour,

        appBar: AppBar(
          backgroundColor: AppStyle.mainColor,
          title: const Text('Note'),
          actions: <Widget>[

            // Let the user delete the notes
            IconButton(
              icon: const Icon(Icons.delete),

              // If the user click the delete icon
              onPressed: () async {

                // Show the alert before user delete the notes
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Are you confirm to delete this note?',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Colors.red,

                  // If the user confirm to delete the notes
                  onConfirmBtnTap: () async {
                    // The notes will be removed from the firebase
                    await FirebaseFirestore.instance.
                        collection("Notes")
                        .doc(docID)
                        .delete()
                        .then((_) => print('Deleted'))
                        .catchError((error) => print('Delete failed: $error'));
                    // Need to pop out two time, first time for alert, second time go to home page
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                  );

              },
            ),
          ],
        ),

      //
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Text field that show the note title and let the user edit the title
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

            // Text field that show the note create date
            Expanded(
                flex:0,
                child: Text(
                  timestampToDateString(widget.doc["create_date"]),
                  style: AppStyle.dateTitle,)
            ),

            // Text field that show the note content and let the user edit the content
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

        // That is a save button to let the user save their edit
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,

          // If the user click the button
          onPressed: () async{

            // The firebase will update the note information according to the user input
            FirebaseFirestore.instance.collection('Notes').doc(docID).update({
              "note_title":_titleControlller.text,
              "create_date":DateTime.now(),
              "note_content":_mainControlller.text,
              "colour_id": color_id,

            }).then((result){
              // Print update successfully and pop out the screen
              print('Update successfully');
              Navigator.pop(context);
            }).catchError((error) =>
                // If failed to update, print why
                print("Failed to update the note due to $error"));
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
