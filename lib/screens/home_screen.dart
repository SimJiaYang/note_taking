import 'package:flutter/material.dart';
import 'package:note_taking/screens/note_editor.dart';
import 'package:note_taking/screens/search_screen.dart';
import 'package:note_taking/services/dbConfig.dart';
import 'package:note_taking/style/app_style.dart';

// Home screen will show all the notes save by the user
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
var search;

@override
// Update the search term at the beginning
void initState(){
  // Let the user view all the note by set the search variable to empty
  updateSearch('');
  super.initState();
}

// Update the search term after user search
void updateSearch(searchTerm){
  setState(() {
    search = searchTerm;
  });
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Notes"),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),

      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[

                  // A button to let user view all the notes
                  Expanded(
                    flex:1,
                    child: TextButton(
                      onPressed: () async{
                        // Set the search term to ' ', than user can view all the notes
                        var searchNote = '';

                        // Let the user view all the note by set the search variable to empty
                        if(search != null){
                          updateSearch(searchNote);
                        }

                      },
                      child: Text("Your recent notes",
                        style: AppStyle.subTitle),
                    ),
                    
                  ),

                  // A button go to the search pages
                  Expanded(
                    flex:0,
                    child: TextButton(
                      onPressed: () async{
                        // Direct the user to the search page, and get the result from the search page
                        var searchNote = await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SearchScreen();
                        }));

                        // If the search screen result not return null, update it to show the search result
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

              Expanded(
                child:
                // If the search is empty, show all the content, else show the user search content
                // FirebaseConfig is come from DB config
                search == '' ? FirebaseConfig(''): FirebaseConfig(search),
              ),

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Go to the add notes screen
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }

}
