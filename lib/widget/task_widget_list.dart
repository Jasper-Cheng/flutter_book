import 'package:flutter/material.dart';
import 'package:flutter_book/beans/task_bean.dart';
import 'package:flutter_book/datebase/task_db_worker.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../generated/l10n.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class TaskWidgetList extends StatelessWidget {
  const TaskWidgetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TaskModel>(
      model: TaskModel.taskModel,
      child: ScopedModelDescendant<TaskModel>(
        builder: (BuildContext context, Widget? child, TaskModel model){
          return Scaffold(
            body: ListView.builder(
              padding: EdgeInsets.fromLTRB(0,10.dp,0,0),
              itemCount: TaskModel.taskModel.entityList.length,
              itemBuilder: (BuildContext inBuildContext,int inIndex){
                TaskBean taskBean=TaskModel.taskModel.entityList[inIndex];
                return Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    extentRatio: 0.2,
                    motion: const ScrollMotion(),
                    // dismissible: DismissiblePane(onDismissed: (){}),
                    children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: S.of(inBuildContext).delete,
                        onPressed: (context){
                          _deleteTask(context,taskBean);
                        },
                      )
                    ],
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: taskBean.completed == "true" ? true : false,
                      onChanged: (inValue) async {
                        taskBean.completed = inValue.toString();
                        await TaskDBWorker.db.update(taskBean);
                        TaskModel.taskModel.loadData(Constant.taskDBTableName, TaskDBWorker.db);
                      },
                    ),
                    title: Text("${taskBean.description}",
                        style: taskBean.completed == "true"?
                        TextStyle(
                          color: Theme.of(inBuildContext).disabledColor,
                          decoration: TextDecoration.lineThrough):
                      TextStyle(
                        color: Theme.of(inBuildContext).textTheme.titleMedium?.color
                      ),
                    ),
                    subtitle: taskBean.dueDate == null ? null :
                    Text(taskBean.dueDate ?? "",
                      style: taskBean.completed == "true" ? TextStyle(
                        color: Theme.of(inBuildContext).disabledColor,
                        decoration: TextDecoration.lineThrough) :
                      TextStyle(
                        color: Theme.of(inBuildContext).textTheme.titleMedium?.color
                      ),
                    ),
                    onTap: () async {
                      if(taskBean.completed == "true")return;
                      TaskModel.taskModel.entityBeingEdited = await TaskDBWorker.db.get(taskBean.id ?? 1);
                      if(TaskModel.taskModel.entityBeingEdited.dueDate == null){
                        TaskModel.taskModel.setChosenDate("");
                      }else{
                        TaskModel.taskModel.setChosenDate(taskBean.dueDate ?? "");
                      }
                      TaskModel.taskModel.setStackIndex(1);
                    },
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                TaskModel.taskModel.entityBeingEdited=null;
                TaskModel.taskModel.setStackIndex(1);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Future _deleteTask(BuildContext inContext, TaskBean inTaskBean){
    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext){
          return AlertDialog(
            title: Text(S.of(inContext).task_list_alert_title),
            content: Text(
              S.of(inContext).task_list_alert_content_part1+"${inTaskBean.description}"+S.of(inContext).task_list_alert_content_part2
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(inAlertContext).pop();
                  },
                  child: Text(S.of(inContext).cancel)
              ),
              TextButton(
                  onPressed: () async {
                    await TaskDBWorker.db.delete(inTaskBean.id ?? 1);
                    Navigator.of(inAlertContext).pop();
                    ScaffoldMessenger.of(inAlertContext).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                        content: Text(S.of(inContext).task_list_alert_action_scaffold_content),
                      )
                    );
                    TaskModel.taskModel.loadData(Constant.taskDBTableName, TaskDBWorker.db);
                  },
                  child: Text(S.of(inContext).sure)
              )
            ],
          );
        }
    );
  }

}
