import 'package:flutter/material.dart';
import 'package:flutter_book/beans/appointment_bean.dart';
import 'package:flutter_book/datebase/appointment_db_worker.dart';
import 'package:flutter_book/models/appointment_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../generated/l10n.dart';
import '../utils/constants.dart';

class AppointmentWidgetList extends StatelessWidget {
  const AppointmentWidgetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppointmentModel>(
      model: AppointmentModel.appointmentModel,
      child: ScopedModelDescendant<AppointmentModel>(
        builder: (BuildContext context, Widget? child, AppointmentModel model) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                AppointmentModel.appointmentModel.entityBeingEdited = null;
                AppointmentModel.appointmentModel.setStackIndex(1);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.dp),
                    child: CalendarCarousel<Event>(
                      thisMonthDayBorderColor: Colors.grey,
                      daysHaveCircularBorder: false,
                      markedDatesMap: _buildEvent(),
                      onDayLongPressed: (DateTime inDate) {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            isScrollControlled: false,
                            isDismissible: true,
                            builder: (BuildContext inContext) {
                              return ScopedModel<AppointmentModel>(
                                model: AppointmentModel.appointmentModel,
                                child: ScopedModelDescendant<AppointmentModel>(
                                  builder: (BuildContext context, Widget? child,
                                      AppointmentModel model) {
                                    return Container(
                                      padding: EdgeInsets.all(10.dp),
                                      child: GestureDetector(
                                        child: Column(
                                          children: [
                                            Text(
                                              DateFormat.yMMMMEEEEd("en_Us")
                                                  .format(inDate.toLocal()),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Theme.of(inContext)
                                                      .colorScheme
                                                      .secondary,
                                                  fontSize: 24.sp),
                                            ),
                                            const Divider(),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: AppointmentModel
                                                    .appointmentModel
                                                    .entityList
                                                    .length,
                                                itemBuilder: (BuildContext
                                                        inBuildContext,
                                                    int inIndex) {
                                                  AppointmentBean
                                                      appointmentBean =
                                                      AppointmentModel
                                                          .appointmentModel
                                                          .entityList[inIndex];
                                                  if (appointmentBean.appDate !=
                                                      "${inDate.year},${inDate.month},${inDate.day}") {
                                                    return Container();
                                                  }
                                                  return Slidable(
                                                    key: const ValueKey(0),
                                                    startActionPane: ActionPane(
                                                      extentRatio: 0.2,
                                                      motion:
                                                          const ScrollMotion(),
                                                      // dismissible: DismissiblePane(onDismissed: (){}),
                                                      children: [
                                                        SlidableAction(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          backgroundColor:
                                                              Colors.red,
                                                          icon: Icons.delete,
                                                          label: S.of(inBuildContext).delete,
                                                          onPressed: (context) {
                                                            _deleteAppointment(
                                                                context,
                                                                appointmentBean);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    child: Container(
                                                      margin:
                                                      EdgeInsets.only(
                                                              bottom: 8.dp),
                                                      color:
                                                          Colors.grey.shade300,
                                                      child: ListTile(
                                                        title: Text(
                                                            "${appointmentBean.title}   ${appointmentBean.appTime}"),
                                                        subtitle: appointmentBean
                                                                    .description ==
                                                                null
                                                            ? null
                                                            : Text(
                                                                "${appointmentBean.description}"),
                                                        onTap: () async {
                                                          _editAppointment(
                                                              inContext,
                                                              appointmentBean);
                                                        },
                                                      ),
                                                    ),
                                                  );
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
                            });
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future _deleteAppointment(
      BuildContext inContext, AppointmentBean inAppointmentBean) {
    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: Text(S.of(inContext).appointment_list_alert_title),
            content: Text(
                S.of(inContext).appointment_list_alert_content_part1+"${inAppointmentBean.title}"+S.of(inContext).appointment_list_alert_content_part2),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(inAlertContext).pop();
                  },
                  child: Text(S.of(inContext).cancel)),
              TextButton(
                  onPressed: () async {
                    await AppointmentDBWorker.db
                        .delete(inAppointmentBean.id ?? 1);
                    Navigator.of(inAlertContext).pop();
                    ScaffoldMessenger.of(inAlertContext)
                        .showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                      content: Text(S.of(inContext).appointment_list_alert_action_scaffold_content),
                    ));
                    AppointmentModel.appointmentModel
                        .loadData(Constant.appointmentDBTableName, AppointmentDBWorker.db);
                  },
                  child: Text(S.of(inContext).sure))
            ],
          );
        });
  }

  EventList<Event> _buildEvent() {
    EventList<Event> _markDateMap = EventList(events: {});
    for (var element in AppointmentModel.appointmentModel.entityList) {
      List dataParts = element.appDate.split(",");
      _markDateMap.add(
          DateTime(int.parse(dataParts[0]),int.parse(dataParts[1]),int.parse(dataParts[2])),
          Event(
              date: DateTime(int.parse(dataParts[0]),int.parse(dataParts[1]),int.parse(dataParts[2])),
              icon: Container(
                decoration: const BoxDecoration(color: Colors.blue),
              )));
    }
    return _markDateMap;
  }

  Future _editAppointment(
      BuildContext inContext, AppointmentBean inAppointmentBean) async {
    AppointmentModel.appointmentModel.entityBeingEdited =
        await AppointmentDBWorker.db.get(inAppointmentBean.id ?? 1);
    AppointmentModel.appointmentModel.setChosenDate(
        AppointmentModel.appointmentModel.entityBeingEdited.appDate);
    AppointmentModel.appointmentModel.setAppTime(
        AppointmentModel.appointmentModel.entityBeingEdited.appTime);
    AppointmentModel.appointmentModel.setStackIndex(1);
    Navigator.pop(inContext);
  }
}
