import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';
import '../screens/note_reader.dart';
import '../widgets/note_card.dart';

class FirebaseConfig extends StatefulWidget {
  const FirebaseConfig(this.search, {super.key});
  final search;

  @override
  State<FirebaseConfig> createState() => _FirebaseConfigState();
}

class _FirebaseConfigState extends State<FirebaseConfig> {
  var search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      buildNoteGrid(widget.search),
        backgroundColor: AppStyle.mainColor,
    );
  }
}

List<QueryDocumentSnapshot> searchNotes(String searchTerm, List<QueryDocumentSnapshot> notes) {

  return notes.where((note) {
    final content = note.get('note_content').toString().toLowerCase();
    return content.contains(searchTerm.toLowerCase());
  }).toList();

}

Widget buildNoteGrid(String searchTerm) {

  return StreamBuilder<QuerySnapshot>(

    stream: FirebaseFirestore.instance
        .collection("Notes")
        .orderBy('create_date', descending: true)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //If the data is loading....
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      print(searchTerm);
      if (snapshot.hasData) {
        final notes = snapshot.data!.docs;
        final filteredNotes = searchNotes(searchTerm, notes);

        if(filteredNotes.length != 0){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),

            //Get the note length
            itemCount: filteredNotes.length,
            itemBuilder: (BuildContext context, int index) {
              final note = filteredNotes[index];
              return noteCard(
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteReaderScreen(note),
                  ),
                ),
                note,
              );
            },
          );
        }

        // Show content no found
        return Text('Can\'t find the content\n'
              'Please try again!',
            style:AppStyle.subTitle,
          );
      }
        return Text(
          " There's is no Notes",
          style: AppStyle.prompt,
      );
    },
  );
}



