import 'package:flutter/material.dart';
import 'package:flutter_book/datebase/note_db_worker.dart';
import 'package:flutter_book/models/note_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/constants.dart';
import 'note_widget_entry.dart';
import 'note_widget_list.dart';

class NoteWidget extends StatelessWidget {

  NoteWidget({Key? key}) : super(key: key){

    NoteModel.noteModel.loadData(Constant.noteDBTableName, NoteDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10.dp),
      child: ScopedModel<NoteModel>(
        model: NoteModel.noteModel,
        child: ScopedModelDescendant<NoteModel>(
          builder: (BuildContext context, Widget? child, NoteModel model){
            return IndexedStack(
              index: model.stackIndex,
              children: [const NoteWidgetList(),NoteWidgetEntry()],
            );
          },
        ),
      ),
    );
  }
}
