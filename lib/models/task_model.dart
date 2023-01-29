import 'package:flutter_book/models/base_model.dart';

import '../datebase/task_db_worker.dart';

class TaskModel extends BaseModel{
  static final TaskModel taskModel = TaskModel._internal();
  factory TaskModel() {
    return taskModel;
  }
  TaskModel._internal();


  //用来选择时间时界面更新，不然可以使用entityBeingEdited.dueDate代替
  String? chosenDate;

  void setChosenDate(String inDate){
    chosenDate=inDate;
    notifyListeners();
  }


  void loadData(String inEntityType,TaskDBWorker inDatabase) async {
    entityList=await inDatabase.getAll();
    notifyListeners();
  }
}