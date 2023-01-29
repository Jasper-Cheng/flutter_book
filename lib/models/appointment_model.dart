import 'package:flutter_book/models/base_model.dart';

import '../datebase/appointment_db_worker.dart';

class AppointmentModel extends BaseModel{
  static final AppointmentModel appointmentModel = AppointmentModel._internal();
  factory AppointmentModel() {
    return appointmentModel;
  }
  AppointmentModel._internal();


  //用来选择时间时界面更新，不然可以使用entityBeingEdited.appDate代替
  String? chosenDate;

  //用来选择时间时界面更新，不然可以使用entityBeingEdited.appTime代替
  String? appTime;

  void setChosenDate(String inDate){
    chosenDate=inDate;
    notifyListeners();
  }

  void setAppTime(String inTime){
    appTime=inTime;
    notifyListeners();
  }


  void loadData(String inEntityType,AppointmentDBWorker inDatabase) async {
    entityList=await inDatabase.getAll();
    notifyListeners();
  }
}