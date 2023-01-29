import 'package:flutter/material.dart';
import 'package:flutter_book/beans/appointment_bean.dart';
import 'package:flutter_book/datebase/appointment_db_worker.dart';
import 'package:flutter_book/models/appointment_model.dart';
import 'package:flutter_book/models/task_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_book/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

import '../generated/l10n.dart';
import '../utils/constants.dart';

class AppointmentWidgetEntry extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AppointmentWidgetEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //防止第一次启动时未设置entityBeingEdited报错
    if(AppointmentModel.appointmentModel.entityBeingEdited==null){
      AppointmentModel.appointmentModel.entityBeingEdited=AppointmentBean();
      AppointmentModel.appointmentModel.entityBeingEdited.appDate=Utils.getYMDCurrentDate();
      AppointmentModel.appointmentModel.entityBeingEdited.appTime=Utils.getHMCurrentDate();
      AppointmentModel.appointmentModel.setChosenDate(AppointmentModel.appointmentModel.entityBeingEdited.appDate);
      AppointmentModel.appointmentModel.setAppTime(AppointmentModel.appointmentModel.entityBeingEdited.appTime);
    }

    return ScopedModel(
      model: TaskModel.taskModel,
      child: ScopedModelDescendant<AppointmentModel>(
        builder: (BuildContext inContext, Widget? inChild, AppointmentModel inModel){
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.dp),
              child: Row(
                children: [
                  TextButton(
                    child: Text(S.of(inContext).cancel),
                    onPressed: (){
                      FocusScope.of(inContext).requestFocus(FocusNode());
                      inModel.setStackIndex(0);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: Text(S.of(inContext).sure),
                    onPressed: (){
                      _save(inContext,inModel);
                    },
                  ),
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.title),
                    title: TextFormField(
                      initialValue: AppointmentModel.appointmentModel.entityBeingEdited.title,
                      decoration: InputDecoration(hintText: S.of(inContext).appointment_entry_list_title_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).appointment_entry_list_title_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        AppointmentModel.appointmentModel.entityBeingEdited.title=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: TextFormField(
                      initialValue: AppointmentModel.appointmentModel.entityBeingEdited.description,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: InputDecoration(hintText: S.of(inContext).appointment_entry_list_description_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).appointment_entry_list_description_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        AppointmentModel.appointmentModel.entityBeingEdited.description=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.today),
                    title: Text(S.of(inContext).date),
                    subtitle: Text(AppointmentModel.appointmentModel.chosenDate??""),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        String chosenDate = await Utils.selectDateFromAppointment(inContext, AppointmentModel.appointmentModel, AppointmentModel.appointmentModel.entityBeingEdited.appDate);
                        if(chosenDate!=null&&chosenDate.isNotEmpty){
                          AppointmentModel.appointmentModel.entityBeingEdited.appDate= chosenDate;
                          //通知界面改变
                          AppointmentModel.appointmentModel.setChosenDate(chosenDate);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: Text(S.of(inContext).time),
                    subtitle: Text(AppointmentModel.appointmentModel.appTime??""),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        String chosenTime = await Utils.selectTimeFromAppointment(inContext);
                        if(chosenTime!=null&&chosenTime.isNotEmpty){
                          AppointmentModel.appointmentModel.entityBeingEdited.appTime= chosenTime;
                          //通知界面改变
                          AppointmentModel.appointmentModel.setAppTime(chosenTime);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _save(BuildContext inContext, AppointmentModel inModel) async {
    if(_formKey.currentState==null||!_formKey.currentState!.validate())return;

    if(inModel.entityBeingEdited.id==null){
      await AppointmentDBWorker.db.create(AppointmentModel.appointmentModel.entityBeingEdited);
    }else{
      await AppointmentDBWorker.db.update(AppointmentModel.appointmentModel.entityBeingEdited);
    }

    AppointmentModel.appointmentModel.loadData(Constant.appointmentDBTableName, AppointmentDBWorker.db);

    inModel.setStackIndex(0);

    ScaffoldMessenger.of(inContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          content: Text(S.of(inContext).appointment_entry_save_scaffold_text),
        )
    );
  }


}
