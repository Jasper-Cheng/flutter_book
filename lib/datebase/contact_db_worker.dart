import 'package:flutter_book/beans/contact_bean.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ContactDBWorker{
  static final ContactDBWorker db=ContactDBWorker();

  Database? _db;

  Future get database async{
    _db ??= await init();
    return _db;
  }

  Future<Database> init() async{
    String path = join(Utils.docsDir.path,Constant.contactDBName);
    Database db = await openDatabase(
        path,version: 1,onOpen: (db){},
        onCreate: (Database inDB, int inVersion) async{
          await inDB.execute(
              "CREATE TABLE IF NOT EXISTS "+Constant.contactDBTableName+" ( id INTEGER PRIMARY KEY,name TEXT,email TEXT,phone TEXT,birthday TEXT)"
          );
        }
    );
    return db;
  }

  Future create(ContactBean inContactBean) async{
    Database db= await database;
    var val=await db.rawQuery("SELECT MAX(id) FROM contacts");
    Object? id=val.first["MAX(id)"];
    id==null ? id=1:id=int.parse(id.toString())+1;

    return await db.rawInsert("INSERT INTO "+Constant.contactDBTableName+" (id,name,email,phone,birthday) VALUES(?,?,?,?,?)",[id,inContactBean.name,inContactBean.email,inContactBean.phone,inContactBean.birthday]);
  }

  Future<List> getAll() async{
    Database db = await database;
    var recs = await db.query(Constant.contactDBTableName);
    var list = recs.isNotEmpty ? recs.map((e) => contactFromMap(e)).toList():[];
    return list;
  }

  Future<ContactBean> get(int inId) async {
    Database db= await database;
    var rec = await db.query(Constant.contactDBTableName,where: "id=?",whereArgs: [inId]);
    return contactFromMap(rec.first);
  }

  Future update(ContactBean inContactBean) async{
    Database db= await database;
    return await db.update(Constant.contactDBTableName,contactToMap(inContactBean),where: "id=?",whereArgs: [inContactBean.id]);
  }

  Future delete(int inID) async {
    Database db = await database;
    return await db.delete(Constant.contactDBTableName,where: "id=?",whereArgs: [inID]);
  }


  ContactBean contactFromMap(Map inMap){
    ContactBean contactBean=ContactBean();
    contactBean.id=inMap["id"];
    contactBean.name=inMap["name"];
    contactBean.email=inMap["email"];
    contactBean.phone=inMap["phone"];
    contactBean.birthday=inMap["birthday"];
    return contactBean;
  }

  Map<String,dynamic> contactToMap(ContactBean inContactBean){
    Map<String,dynamic> map=<String,dynamic>{};
    map["id"]=inContactBean.id;
    map["name"]=inContactBean.name;
    map["email"]=inContactBean.email;
    map["phone"]=inContactBean.phone;
    map["birthday"]=inContactBean.birthday;
    return map;
  }


}