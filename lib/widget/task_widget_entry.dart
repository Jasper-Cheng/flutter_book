import 'package:flutter/material.dart';
import 'package:flutter_book/models/task_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_book/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

import '../beans/task_bean.dart';
import '../datebase/task_db_worker.dart';
import '../generated/l10n.dart';
import '../utils/constants.dart';

class TaskWidgetEntry extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TaskWidgetEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //防止第一次启动时未设置entityBeingEdited报错
    if(TaskModel.taskModel.entityBeingEdited==null){
      TaskModel.taskModel.entityBeingEdited=TaskBean();
      TaskModel.taskModel.entityBeingEdited.dueDate=Utils.getYMDCurrentDate();
      TaskModel.taskModel.setChosenDate(TaskModel.taskModel.entityBeingEdited.dueDate);
    }

    return ScopedModel(
      model: TaskModel.taskModel,
      child: ScopedModelDescendant<TaskModel>(
        builder: (BuildContext inContext, Widget? inChild, TaskModel inModel){
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
                    leading: const Icon(Icons.description),
                    title: TextFormField(
                      initialValue: TaskModel.taskModel.entityBeingEdited.description,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: InputDecoration(hintText: S.of(inContext).task_entry_list_description_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).task_entry_list_description_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        TaskModel.taskModel.entityBeingEdited.description=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.today),
                    title: Text(S.of(inContext).date),
                    subtitle: Text(TaskModel.taskModel.chosenDate??""),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        String chosenDate = await Utils.selectDateFormTask(inContext, TaskModel.taskModel, TaskModel.taskModel.entityBeingEdited.dueDate);
                        if(chosenDate!=null&&chosenDate.isNotEmpty){
                          TaskModel.taskModel.entityBeingEdited.dueDate= chosenDate;
                          //通知界面改变
                          TaskModel.taskModel.setChosenDate(chosenDate);
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

  void _save(BuildContext inContext, TaskModel inModel) async {
    if(_formKey.currentState==null||!_formKey.currentState!.validate())return;

    if(inModel.entityBeingEdited.id==null){
      await TaskDBWorker.db.create(TaskModel.taskModel.entityBeingEdited);
    }else{
      await TaskDBWorker.db.update(TaskModel.taskModel.entityBeingEdited);
    }

    TaskModel.taskModel.loadData(Constant.taskDBTableName, TaskDBWorker.db);

    inModel.setStackIndex(0);

    ScaffoldMessenger.of(inContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          content: Text(S.of(inContext).task_entry_save_scaffold_text),
        )
    );
  }


}
