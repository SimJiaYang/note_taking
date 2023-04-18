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
  // Initialize the variable search
  var search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        // Show the note based on the variable search
        buildNoteGrid(widget.search),
        backgroundColor: AppStyle.mainColor,
    );
  }
}

List<QueryDocumentSnapshot> searchNotes(String searchTerm, List<QueryDocumentSnapshot> notes) {
  // Get all the notes which contain the 'search' term enter by the user
  return notes.where((note) {
    final content = note.get('note_content').toString().toLowerCase();
    return content.contains(searchTerm.toLowerCase());
  }).toList();

}

Widget buildNoteGrid(String searchTerm) {

  return StreamBuilder<QuerySnapshot>(

    // Show all the result according to the create date by descending
    stream: FirebaseFirestore.instance
        .collection("Notes")
        .orderBy('create_date', descending: true)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

      //If the data is loading.... show the CircularProgress Indicator
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }


      // If firebase has data about 'Notes' firebase
      if (snapshot.hasData) {
        final notes = snapshot.data!.docs;

        // Get all the notes which contain the 'search' term enter by the user
        final filteredNotes = searchNotes(searchTerm, notes);

        // If the search result length not equal to zero
        if(filteredNotes.length != 0){

          // Return the gridview
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),

            // Gridview get the note length
            itemCount: filteredNotes.length,

            // Gridview method to build the content
            itemBuilder: (BuildContext context, int index) {
              final note = filteredNotes[index];

              // Return the NoteCard widget
              return noteCard(
                    () => Navigator.push(
                  context,
                  // Push to the NoteReader Screen
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
        // Show no content in firebase
        return Text(
          " There's is no Notes",
          style:AppStyle.subTitle,
      );
    },
  );
}



