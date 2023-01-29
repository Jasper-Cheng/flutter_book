import 'package:flutter_book/datebase/contact_db_worker.dart';
import 'package:flutter_book/models/base_model.dart';

class ContactModel extends BaseModel{
  static final ContactModel contactModel = ContactModel._internal();
  factory ContactModel() {
    return contactModel;
  }
  ContactModel._internal();


  void triggerRebuild(){
    notifyListeners();
  }

  //用来选择时间时界面更新，不然可以使用entityBeingEdited.birthday代替
  String? chosenDate;


  void setChosenDate(String inDate){
    chosenDate=inDate;
    notifyListeners();
  }

  void loadData(String inEntityType,ContactDBWorker inDatabase) async {
    entityList=await inDatabase.getAll();
    notifyListeners();
  }

}