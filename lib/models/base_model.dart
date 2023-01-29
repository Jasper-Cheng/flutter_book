import 'package:flutter_book/beans/note_bean.dart';
import 'package:scoped_model/scoped_model.dart';

import '../datebase/note_db_worker.dart';

class BaseModel extends Model{
  //indexStack当前显示页
  int stackIndex=0;
  //数据查询实体的列表
  List entityList=[];
  //当前编辑的实体
  var entityBeingEdited;


  void setStackIndex(int inStackIndex){
    stackIndex=inStackIndex;
    notifyListeners();
  }

}