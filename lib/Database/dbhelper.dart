import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/notesmodel.dart';

class DbHelper{
  DbHelper._();
  static final DbHelper instance=DbHelper._();
  static final note_table="note_table";
  static final note_id="note_id";
  static final note_title="note_title";
  static final note_desc="note_desc";
  Database? _database;

  Future<Database>getDb()async{
    if(_database!=null){
      return _database!;
    }
    else{
      return await initDb();
    }
  }
  Future<Database>initDb()async{
    Directory directory =await getApplicationDocumentsDirectory();
    var dbpath=join(directory.path+"notesdb.db");
    return openDatabase(dbpath,version: 1,onCreate: (db,version){
      return db.execute("create table $note_table($note_id integer primary key autoincrement,$note_title text,$note_desc text)");
    });
  }

  addNotes(NotesModel notesModel)async{
    var db= await getDb();
    db.insert(note_table, notesModel.toMap());
  }

  Future<List<NotesModel>>getNotes()async{
    var db= await getDb();
    List<NotesModel>listnotes=[];
    var data= await db.query(note_table);
    for(Map<String,dynamic>eachdata in data){
      NotesModel notesModel =NotesModel.fromMap(eachdata);
      listnotes.add(notesModel);

    }
    return listnotes;

  }
  Future<void>UpdateNotes(NotesModel notesModel)async{
    var db= await getDb();
    db.update(note_table, notesModel.toMap(), where: "$note_id=${notesModel.id}");

  }
  Future<bool>DeleteNotes(int id)async{
    var db= await getDb();
    var count= await db.delete(note_table, where: "$note_id=?", whereArgs:[id.toString()] );
    return count>0;


  }


}
