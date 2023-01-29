import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_book/models/appointment_model.dart';
import 'package:flutter_book/models/contact_model.dart';

import '../models/task_model.dart';

class Utils{
  static late final Directory docsDir;

  static String getYMDCurrentDate(){
    DateTime currentDate = DateTime.now();
    return "${currentDate.year},${currentDate.month},${currentDate.day}";
  }

  static String getHMCurrentDate(){
    DateTime currentDate = DateTime.now();
    return "${currentDate.hour}:${currentDate.minute}";
  }

  static Future selectDateFormTask(BuildContext inContext,TaskModel inModel,String inDateString) async {
    DateTime initialDate = DateTime.now();
    if(inDateString.isNotEmpty){
      List dataParts = inDateString.split(",");
      initialDate = DateTime(int.parse(dataParts[0]),int.parse(dataParts[1]),int.parse(dataParts[2]));
    }
    DateTime? picked = await showDatePicker(
        context: inContext,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if(picked != null){
      return "${picked.year},${picked.month},${picked.day}";
    }
  }

  static Future selectDateFromAppointment(BuildContext inContext,AppointmentModel inModel,String inDateString) async {
    DateTime initialDate = DateTime.now();
    if(inDateString.isNotEmpty){
      List dataParts = inDateString.split(",");
      initialDate = DateTime(int.parse(dataParts[0]),int.parse(dataParts[1]),int.parse(dataParts[2]));
    }
    DateTime? picked = await showDatePicker(
        context: inContext,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if(picked != null){
      return "${picked.year},${picked.month},${picked.day}";
    }
  }

  static Future selectTimeFromAppointment(BuildContext inContext) async {
    TimeOfDay initialTime = TimeOfDay.now();
    if(AppointmentModel.appointmentModel.entityBeingEdited.appTime != null){
      List timeParts = AppointmentModel.appointmentModel.entityBeingEdited.appTime.split(":");
      initialTime = TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
    }

    TimeOfDay? picked = await showTimePicker(context: inContext, initialTime: initialTime);
    if(picked != null){
      return "${picked.hour}:${picked.minute}";
    }
  }


  static Future selectDateFormContact(BuildContext inContext,ContactModel inModel,String inDateString) async {
    DateTime initialDate = DateTime.now();
    if(inDateString.isNotEmpty){
      List dataParts = inDateString.split(",");
      initialDate = DateTime(int.parse(dataParts[0]),int.parse(dataParts[1]),int.parse(dataParts[2]));
    }
    DateTime? picked = await showDatePicker(
        context: inContext,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if(picked != null){
      return "${picked.year},${picked.month},${picked.day}";
    }
  }


}