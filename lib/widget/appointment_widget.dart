import 'package:flutter/material.dart';
import 'package:flutter_book/models/appointment_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:scoped_model/scoped_model.dart';

import '../datebase/appointment_db_worker.dart';
import '../utils/constants.dart';
import 'appointment_widget_entry.dart';
import 'appointment_widget_list.dart';

class AppointmentWidget extends StatelessWidget {
  AppointmentWidget({Key? key}) : super(key: key){

    AppointmentModel.appointmentModel.loadData(Constant.appointmentDBTableName, AppointmentDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dp),
      child: ScopedModel<AppointmentModel>(
        model: AppointmentModel.appointmentModel,
        child: ScopedModelDescendant<AppointmentModel>(
          builder: (BuildContext context, Widget? child, AppointmentModel model){
            return IndexedStack(
              index: model.stackIndex,
              children: [const AppointmentWidgetList(),AppointmentWidgetEntry()],
            );
          },
        ),
      ),
    );
  }
}
