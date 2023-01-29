import 'package:flutter_book/beans/task_bean.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class TaskDBWorker{
  static final TaskDBWorker db=TaskDBWorker();

  Database? _db;

  Future get database async{
    _db ??= await init();
    return _db;
  }

  Future<Database> init() async{
    String path = join(Utils.docsDir.path,Constant.taskDBName);
    Database db = await openDatabase(
        path,version: 1,onOpen: (db){},
        onCreate: (Database inDB, int inVersion) async{
          await inDB.execute(
              "CREATE TABLE IF NOT EXISTS "+Constant.taskDBTableName+" ( id INTEGER PRIMARY KEY,description TEXT,dueDate TEXT,completed TEXT)"
          );
        }
    );
    return db;
  }

  Future create(TaskBean inTaskBean) async{
    Database db= await database;
    var val=await db.rawQuery("SELECT MAX(id) FROM tasks");
    Object? id=val.first["MAX(id)"];
    id==null ? id=1:id=int.parse(id.toString())+1;

    return await db.rawInsert("INSERT INTO "+Constant.taskDBTableName+" (id,description,dueDate,completed) VALUES(?,?,?,?)",[id,inTaskBean.description,inTaskBean.dueDate,inTaskBean.completed]);
  }

  Future<List> getAll() async{
    Database db = await database;
    var recs = await db.query(Constant.taskDBTableName);
    var list = recs.isNotEmpty ? recs.map((e) => taskFromMap(e)).toList():[];
    return list;
  }

  Future<TaskBean> get(int inId) async {
    Database db= await database;
    var rec = await db.query(Constant.taskDBTableName,where: "id=?",whereArgs: [inId]);
    return taskFromMap(rec.first);
  }

  Future update(TaskBean inTaskBean) async{
    Database db= await database;
    return await db.update(Constant.taskDBTableName,taskToMap(inTaskBean),where: "id=?",whereArgs: [inTaskBean.id]);
  }

  Future delete(int inID) async {
    Database db = await database;
    return await db.delete(Constant.taskDBTableName,where: "id=?",whereArgs: [inID]);
  }


  TaskBean taskFromMap(Map inMap){
    TaskBean taskBean=TaskBean();
    taskBean.id=inMap["id"];
    taskBean.description=inMap["description"];
    taskBean.dueDate=inMap["dueDate"];
    taskBean.completed=inMap["completed"];
    return taskBean;
  }

  Map<String,dynamic> taskToMap(TaskBean inTaskBean){
    Map<String,dynamic> map=<String,dynamic>{};
    map["id"]=inTaskBean.id;
    map["description"]=inTaskBean.description;
    map["dueDate"]=inTaskBean.dueDate;
    map["completed"]=inTaskBean.completed;
    return map;
  }


}