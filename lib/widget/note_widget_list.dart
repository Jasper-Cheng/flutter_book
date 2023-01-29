import 'package:flutter/material.dart';
import 'package:flutter_book/datebase/note_db_worker.dart';
import 'package:flutter_book/models/note_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../beans/note_bean.dart';
import '../generated/l10n.dart';
import '../utils/constants.dart';

class NoteWidgetList extends StatelessWidget {
  const NoteWidgetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NoteModel>(
      model: NoteModel.noteModel,
      child: ScopedModelDescendant<NoteModel>(
        builder: (BuildContext context, Widget? child, NoteModel model){
          return Scaffold(
            body: ListView.builder(
              itemCount: NoteModel.noteModel.entityList.length,
              itemBuilder: (BuildContext inBuildContext, int inIndex){
                NoteBean noteBean=NoteModel.noteModel.entityList[inIndex];
                Color color = Colors.white;
                switch(noteBean.color){
                  case "red" : color = Colors.red;break;
                  case "green" : color = Colors.green;break;
                  case "blue" : color = Colors.blue;break;
                  case "yellow" : color = Colors.yellow;break;
                  case "white" : color = Colors.white;break;
                  case "purple" : color = Colors.purple;break;
                }
                return Container(
                  margin: EdgeInsets.fromLTRB(10.dp, 20.dp, 0, 0),
                  child: Slidable(
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
                            _deleteNote(context,noteBean);
                          },
                        )
                      ],
                    ),
                    child: Card(
                      elevation: 8,
                      color: color,
                      child: ListTile(
                        title: Text("${noteBean.title}"),
                        subtitle: Text("${noteBean.content}"),
                        onTap: () async {
                          NoteModel.noteModel.entityBeingEdited = await NoteDBWorker.db.get(noteBean.id ?? 1);
                          NoteModel.noteModel.setColor(NoteModel.noteModel.entityBeingEdited.color);
                          NoteModel.noteModel.setStackIndex(1);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NoteModel.noteModel.entityBeingEdited=null;
                NoteModel.noteModel.setStackIndex(1);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Future _deleteNote(BuildContext inContext, NoteBean inNoteBean){
    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext){
          return AlertDialog(
            title: Text(S.of(inContext).note_list_alert_title),
            content: Text(
              S.of(inContext).note_list_alert_content_part1+"${inNoteBean.title}"+S.of(inContext).note_list_alert_content_part2
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
                    await NoteDBWorker.db.delete(inNoteBean.id ?? 1);
                    Navigator.of(inAlertContext).pop();
                    ScaffoldMessenger.of(inAlertContext).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                        content: Text(S.of(inContext).note_list_alert_action_scaffold_content),
                      )
                    );
                    NoteModel.noteModel.loadData(Constant.noteDBTableName, NoteDBWorker.db);
                  },
                  child: Text(S.of(inContext).sure)
              )
            ],
          );
        }
    );
  }

}
