import 'package:flutter/material.dart';
import 'package:flutter_book/beans/note_bean.dart';
import 'package:flutter_book/datebase/note_db_worker.dart';
import 'package:flutter_book/models/note_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:scoped_model/scoped_model.dart';

import '../generated/l10n.dart';
import '../utils/constants.dart';

class NoteWidgetEntry extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  NoteWidgetEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //防止第一次启动时未设置entityBeingEdited报错
    if(NoteModel.noteModel.entityBeingEdited == null){
      NoteModel.noteModel.entityBeingEdited=NoteBean();
      NoteModel.noteModel.entityBeingEdited.color="green";
      NoteModel.noteModel.setColor(NoteModel.noteModel.entityBeingEdited.color);
    }

    return ScopedModel(
      model: NoteModel.noteModel,
      child: ScopedModelDescendant<NoteModel>(
        builder: (BuildContext inContext, Widget? inChild, NoteModel inModel){
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
                      initialValue: NoteModel.noteModel.entityBeingEdited.title,
                      decoration: InputDecoration(hintText: S.of(inContext).note_entry_list_title_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).note_entry_list_title_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        NoteModel.noteModel.entityBeingEdited.title=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.content_paste),
                    title: TextFormField(
                      initialValue: NoteModel.noteModel.entityBeingEdited.content,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: InputDecoration(hintText: S.of(inContext).note_entry_list_content_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).note_entry_list_content_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        NoteModel.noteModel.entityBeingEdited.content=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 50.dp,
                            height: 50.dp,
                            decoration: ShapeDecoration(
                              shape: Border.all(width: 20.dp,color: Colors.red)+
                                  Border.all(width: 6.dp,color: NoteModel.noteModel.color == "red" ?
                                  Colors.red : Theme.of(inContext).canvasColor),
                            ),
                          ),
                          onTap: (){
                            NoteModel.noteModel.entityBeingEdited.color="red";
                            NoteModel.noteModel.setColor("red");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            width: 50.dp,
                            height: 50.dp,
                            decoration: ShapeDecoration(
                              shape: Border.all(width: 20.dp,color: Colors.green)+
                                  Border.all(width: 6.dp,color: NoteModel.noteModel.color == "green" ?
                                  Colors.green : Theme.of(inContext).canvasColor),
                            ),
                          ),
                          onTap: (){
                            NoteModel.noteModel.entityBeingEdited.color="green";
                            NoteModel.noteModel.setColor("green");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            width: 50.dp,
                            height: 50.dp,
                            decoration: ShapeDecoration(
                              shape: Border.all(width: 20.dp,color: Colors.blue)+
                                  Border.all(width: 6.dp,color: NoteModel.noteModel.color == "blue" ?
                                  Colors.blue : Theme.of(inContext).canvasColor),
                            ),
                          ),
                          onTap: (){
                            NoteModel.noteModel.entityBeingEdited.color="blue";
                            NoteModel.noteModel.setColor("blue");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            width: 50.dp,
                            height: 50.dp,
                            decoration: ShapeDecoration(
                              shape: Border.all(width: 20.dp,color: Colors.yellow)+
                                  Border.all(width: 6.dp,color: NoteModel.noteModel.color == "yellow" ?
                                  Colors.yellow : Theme.of(inContext).canvasColor),
                            ),
                          ),
                          onTap: (){
                            NoteModel.noteModel.entityBeingEdited.color="yellow";
                            NoteModel.noteModel.setColor("yellow");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            width: 50.dp,
                            height: 50.dp,
                            decoration: ShapeDecoration(
                              shape: Border.all(width: 20.dp,color: Colors.white)+
                                  Border.all(width: 6.dp,color: NoteModel.noteModel.color == "white" ?
                                  Colors.white : Theme.of(inContext).canvasColor),
                            ),
                          ),
                          onTap: (){
                            NoteModel.noteModel.entityBeingEdited.color="white";
                            NoteModel.noteModel.setColor("white");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            width: 50.dp,
                            height: 50.dp,
                            decoration: ShapeDecoration(
                              shape: Border.all(width: 20.dp,color: Colors.purple)+
                                  Border.all(width: 6.dp,color: NoteModel.noteModel.color == "purple" ?
                                  Colors.purple : Theme.of(inContext).canvasColor),
                            ),
                          ),
                          onTap: (){
                            NoteModel.noteModel.entityBeingEdited.color="purple";
                            NoteModel.noteModel.setColor("purple");
                          },
                        ),
                        const Spacer(),
                      ],
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

  void _save(BuildContext inContext, NoteModel inModel) async {
    if(_formKey.currentState==null||!_formKey.currentState!.validate())return;

    if(inModel.entityBeingEdited.id==null){
      await NoteDBWorker.db.create(NoteModel.noteModel.entityBeingEdited);
    }else{
      await NoteDBWorker.db.update(NoteModel.noteModel.entityBeingEdited);
    }

    NoteModel.noteModel.loadData(Constant.noteDBTableName, NoteDBWorker.db);

    inModel.setStackIndex(0);

    ScaffoldMessenger.of(inContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          content: Text(S.of(inContext).note_entry_save_scaffold_text),
        )
    );
  }


}
