import 'package:flutter/material.dart';
import 'package:notes_application_flutter/Widgets/uihelper.dart';

import '../Database/dbhelper.dart';
import '../Models/notesmodel.dart';

class NotesAppScreen extends StatefulWidget {
  @override
  State<NotesAppScreen> createState() => _NotesAppScreenState();
}

class _NotesAppScreenState extends State<NotesAppScreen> {


  late DbHelper dbHelper;
  List<NotesModel>fetchNotesList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper =DbHelper.instance;
  }
  getAllNotes()async{
    fetchNotesList= await dbHelper.getNotes();
    setState(() {
      //to show data in ui that's why set state called
    });

  }
  TextEditingController titleController= TextEditingController();
  TextEditingController descController= TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/girl.png"),
              ),
              SizedBox(width: 10,),
              Text("Hi, Smita"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showModalBottomSheet();

        },
        child: Icon(Icons.add),
      ),

      endDrawer: Drawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Notes", style: TextStyle(fontSize: 50, color: Colors.white)),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                        onPressed: () {}, child: Text("All", style: TextStyle(color: Colors.black),)),
                    SizedBox(width: 10,),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Colors.grey
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {}, child: Text("Important", style: TextStyle(color: Colors.grey),)),
                    SizedBox(width: 10,),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Colors.grey
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {}, child: Text("Bookmarked", style: TextStyle(color: Colors.grey),)),
                    SizedBox(width: 10,),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Colors.grey
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {}, child: Text("Favourite", style: TextStyle(color: Colors.grey),)),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height,
                      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                          itemCount: fetchNotesList.length,
                          itemBuilder: (context,index){
                        return InkWell(
                            onTap: (){
                              titleController.text=fetchNotesList[index].title;
                              descController.text=fetchNotesList[index].desc;
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                return Container(
                                  height: 700,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        UiHelper.CustomTextField(titleController, "Title", Icons.title),
                                        UiHelper.CustomTextField(descController, "Description", Icons.description),
                                        SizedBox(height: 20,),
                                        ElevatedButton(onPressed: (){
                                          var utitle= titleController.text.toString();
                                          var udesc= descController.text.toString();
                                          dbHelper.UpdateNotes(NotesModel(title: utitle, desc: udesc,id: fetchNotesList[index].id));
                                          getAllNotes();
                                        }, child: Text("Update")),



                                      ],

                                  ),
                                );

                              }
                              );},
                            child: GridTile(child:Container(
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue.shade300,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: ()async{
                                              await dbHelper.DeleteNotes(fetchNotesList[index].id!);
                                              getAllNotes();
                                            },
                                          ),),
                                        SizedBox(height: 5,),
                                        Text('${fetchNotesList[index].title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                        SizedBox(height: 10,),
                                        Text("${fetchNotesList[index].desc}"),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ), ));
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _showModalBottomSheet(){
    return showModalBottomSheet(context: context, builder: (BuildContext context){
      return Container(
        height: 700,
        width: 400,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelper.CustomTextField(titleController, "Title", Icons.title),
              UiHelper.CustomTextField(descController, "Description", Icons.description),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                dbHelper.addNotes(NotesModel(title: titleController.text.toString(), desc: descController.text.toString()));
                getAllNotes();
              }, child: Text("Save")),

            ],
          ),
        ),
      );
    });

  }

}