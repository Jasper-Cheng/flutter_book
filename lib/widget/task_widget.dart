import 'package:flutter/material.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_book/widget/task_widget_entry.dart';
import 'package:flutter_book/widget/task_widget_list.dart';
import 'package:scoped_model/scoped_model.dart';

import '../datebase/task_db_worker.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class TaskWidget extends StatelessWidget {
  // const TaskWidget({Key? key}) : super(key: key);
  TaskWidget({Key? key}) : super(key: key){

    TaskModel.taskModel.loadData(Constant.taskDBTableName, TaskDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dp),
      child: ScopedModel<TaskModel>(
        model: TaskModel.taskModel,
        child: ScopedModelDescendant<TaskModel>(
          builder: (BuildContext context, Widget? child, TaskModel model){
            return IndexedStack(
              index: model.stackIndex,
              children: [const TaskWidgetList(),TaskWidgetEntry()],
            );
          },
        ),
      ),
    );
  }
}
