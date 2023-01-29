import 'package:flutter_book/beans/note_bean.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class NoteDBWorker{
  static final NoteDBWorker db=NoteDBWorker();

  Database? _db;

  Future get database async{
    _db ??= await init();
    return _db;
  }

  Future<Database> init() async{
    String path = join(Utils.docsDir.path,Constant.noteDBName);
    Database db = await openDatabase(
      path,version: 1,onOpen: (db){},
      onCreate: (Database inDB, int inVersion) async{
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS "+Constant.noteDBTableName+" ( id INTEGER PRIMARY KEY,title TEXT,content TEXT,color TEXT)"
        );
      }
    );
    return db;
  }

  Future create(NoteBean inNoteBean) async{
    Database db= await database;
    var val=await db.rawQuery("SELECT MAX(id) FROM notes");
    Object? id=val.first["MAX(id)"];
    id==null ? id=1:id=int.parse(id.toString())+1;

    return await db.rawInsert("INSERT INTO "+Constant.noteDBTableName+" (id,title,content,color) VALUES(?,?,?,?)",[id,inNoteBean.title,inNoteBean.content,inNoteBean.color]);
  }

  Future<List> getAll() async{
    Database db = await database;
    var recs = await db.query(Constant.noteDBTableName);
    var list = recs.isNotEmpty ? recs.map((e) => noteFromMap(e)).toList():[];
    return list;
  }

  Future<NoteBean> get(int inId) async {
    Database db= await database;
    var rec = await db.query(Constant.noteDBTableName,where: "id=?",whereArgs: [inId]);
    return noteFromMap(rec.first);
  }

  Future update(NoteBean inNoteBean) async{
    Database db= await database;
    return await db.update(Constant.noteDBTableName,noteToMap(inNoteBean),where: "id=?",whereArgs: [inNoteBean.id]);
  }

  Future delete(int inID) async {
    Database db = await database;
    return await db.delete(Constant.noteDBTableName,where: "id=?",whereArgs: [inID]);
  }


  NoteBean noteFromMap(Map inMap){
    NoteBean noteBean=NoteBean();
    noteBean.id=inMap["id"];
    noteBean.title=inMap["title"];
    noteBean.content=inMap["content"];
    noteBean.color=inMap["color"];
    return noteBean;
  }

  Map<String,dynamic> noteToMap(NoteBean inNoteBean){
    Map<String,dynamic> map=<String,dynamic>{};
    map["id"]=inNoteBean.id;
    map["title"]=inNoteBean.title;
    map["content"]=inNoteBean.content;
    map["color"]=inNoteBean.color;
    return map;
  }


}