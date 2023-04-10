import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/screens/note_editor.dart';
import 'package:note_taking/screens/note_reader.dart';
import 'package:note_taking/screens/search_screen.dart';
import 'package:note_taking/services/dbConfig.dart';
import 'package:note_taking/style/app_style.dart';
import 'package:note_taking/widgets/note_card.dart';
import 'package:note_taking/services/test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
var search;

@override
void initState(){
  updateSearch('');
  super.initState();
}

void updateSearch(searchTerm){
  setState(() {
    search = searchTerm;
  });
}
  @override
  Widget build(BuildContext context) {
    
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("FireNotes"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),

      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                
                Expanded(
                  flex:1,
                  child: TextButton(
                    onPressed: () async{
                      var searchNote = '';

                      // print(search);
                      if(search != null){
                        updateSearch(searchNote);
                      }

                    },
                    child: Text("Your recent notes",
                      style: AppStyle.subTitle),
                  ),
                  
                ),

                Expanded(
                  flex:0,
                  child: TextButton(
                    onPressed: () async{
                      var searchNote = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SearchScreen();
                      }));

                      // print(search);
                      if(searchNote != null){
                        updateSearch(searchNote);
                      }

                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(
              height: 20.0,
            ),

            testing(search),

            Expanded(
              child: 
              search == '' ? FirebaseConfig(''): FirebaseConfig(search),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }

}
