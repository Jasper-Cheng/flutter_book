import 'package:flutter_book/beans/appointment_bean.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class AppointmentDBWorker{
  static final AppointmentDBWorker db=AppointmentDBWorker();

  Database? _db;

  Future get database async{
    _db ??= await init();
    return _db;
  }

  Future<Database> init() async{
    String path = join(Utils.docsDir.path,Constant.appointmentDBName);
    Database db = await openDatabase(
        path,version: 1,onOpen: (db){},
        onCreate: (Database inDB, int inVersion) async{
          await inDB.execute(
              "CREATE TABLE IF NOT EXISTS "+Constant.appointmentDBTableName+" ( id INTEGER PRIMARY KEY,title TEXT,description TEXT,appDate TEXT,appTime TEXT)"
          );
        }
    );
    return db;
  }

  Future create(AppointmentBean inAppointmentBean) async{
    Database db= await database;
    var val=await db.rawQuery("SELECT MAX(id) FROM appointments");
    Object? id=val.first["MAX(id)"];
    id==null ? id=1:id=int.parse(id.toString())+1;

    return await db.rawInsert("INSERT INTO "+Constant.appointmentDBTableName+" (id,title,description,appDate,appTime) VALUES(?,?,?,?,?)",[id,inAppointmentBean.title,inAppointmentBean.description,inAppointmentBean.appDate,inAppointmentBean.appTime]);
  }

  Future<List> getAll() async{
    Database db = await database;
    var recs = await db.query(Constant.appointmentDBTableName);
    var list = recs.isNotEmpty ? recs.map((e) => appointmentFromMap(e)).toList():[];
    return list;
  }

  Future<AppointmentBean> get(int inId) async {
    Database db= await database;
    var rec = await db.query(Constant.appointmentDBTableName,where: "id=?",whereArgs: [inId]);
    return appointmentFromMap(rec.first);
  }

  Future update(AppointmentBean inAppointmentBean) async{
    Database db= await database;
    return await db.update(Constant.appointmentDBTableName,appointmentToMap(inAppointmentBean),where: "id=?",whereArgs: [inAppointmentBean.id]);
  }

  Future delete(int inID) async {
    Database db = await database;
    return await db.delete(Constant.appointmentDBTableName,where: "id=?",whereArgs: [inID]);
  }


  AppointmentBean appointmentFromMap(Map inMap){
    AppointmentBean appointmentBean=AppointmentBean();
    appointmentBean.id=inMap["id"];
    appointmentBean.title=inMap["title"];
    appointmentBean.description=inMap["description"];
    appointmentBean.appDate=inMap["appDate"];
    appointmentBean.appTime=inMap["appTime"];
    return appointmentBean;
  }

  Map<String,dynamic> appointmentToMap(AppointmentBean inAppointmentBean){
    Map<String,dynamic> map=<String,dynamic>{};
    map["id"]=inAppointmentBean.id;
    map["title"]=inAppointmentBean.title;
    map["description"]=inAppointmentBean.description;
    map["appDate"]=inAppointmentBean.appDate;
    map["appTime"]=inAppointmentBean.appTime;
    return map;
  }


}