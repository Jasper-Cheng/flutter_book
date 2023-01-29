import 'package:flutter_book/models/base_model.dart';

import '../datebase/note_db_worker.dart';

class NoteModel extends BaseModel{
  static final NoteModel noteModel = NoteModel._internal();
  factory NoteModel() {
    return noteModel;
  }
  NoteModel._internal();

  //用来选择颜色时界面更新，不然可以使用entityBeingEdited.color代替
  String? color;

  void setColor(String inColor){
    color=inColor;
    notifyListeners();
  }


  void loadData(String inEntityType,NoteDBWorker inDatabase) async {
    entityList=await inDatabase.getAll();
    notifyListeners();
  }
}