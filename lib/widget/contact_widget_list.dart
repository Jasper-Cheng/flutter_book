import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_book/beans/contact_bean.dart';
import 'package:flutter_book/models/contact_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart';

import '../datebase/contact_db_worker.dart';
import '../generated/l10n.dart';
import '../utils/constants.dart';
import '../utils/file_image_ex.dart';
import '../utils/utils.dart';

class ContactWidgetList extends StatelessWidget {
  const ContactWidgetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactModel>(
      model: ContactModel.contactModel,
      child: ScopedModelDescendant<ContactModel>(
        builder: (BuildContext context, Widget? child, ContactModel model) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                File avatarFile = File(join(Utils.docsDir.path,Constant.contactTempImageFileName));
                if(avatarFile.existsSync()){
                  avatarFile.deleteSync();
                }
                ContactModel.contactModel.entityBeingEdited = null;
                ContactModel.contactModel.setStackIndex(1);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: ListView.builder(
              padding: EdgeInsets.fromLTRB(0,10.dp,0,0),
              itemCount: ContactModel.contactModel.entityList.length,
              itemBuilder: (BuildContext inBuildContext,int inIndex){
                ContactBean contactBean=ContactModel.contactModel.entityList[inIndex];
                File avatarFile = File(join(Utils.docsDir.path,contactBean.id.toString()));
                bool avatarFileExists = avatarFile.existsSync();
                return Column(
                    children: [
                      Slidable(
                        key: const ValueKey(0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white,
                            backgroundImage: avatarFileExists ? FileImageEx(avatarFile) : null,
                            child: avatarFileExists ? null : Text(contactBean.name?.substring(0,1).toUpperCase() ?? ""),
                          ),
                          title: Text("${contactBean.name}"),
                          subtitle: contactBean.phone == null? null : Text("${contactBean.phone}"),
                          onTap: () async {
                            File avatarFile = File(join(Utils.docsDir.path,Constant.contactTempImageFileName));
                            if(avatarFile.existsSync()){
                              avatarFile.deleteSync();
                            }
                            ContactModel.contactModel.entityBeingEdited = await ContactDBWorker.db.get(contactBean.id??1);
                            ContactModel.contactModel.setChosenDate(ContactModel.contactModel.entityBeingEdited.birthday);
                            ContactModel.contactModel.setStackIndex(1);
                          },
                        ),
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
                                _deleteContact(context,contactBean);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future _deleteContact(
      BuildContext inContext, ContactBean inContactBean) {
    return showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (BuildContext inAlertContext) {
          return AlertDialog(
            title: Text(S.of(inContext).contact_list_alert_title),
            content: Text(
                S.of(inContext).contact_list_alert_content_part1+"${inContactBean.name}"+S.of(inContext).contact_list_alert_content_part2),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(inAlertContext).pop();
                  },
                  child: Text(S.of(inContext).cancel)),
              TextButton(
                  onPressed: () async {
                    File avatarFile = File(join(Utils.docsDir.path,inContactBean.id.toString()));
                    if(avatarFile.existsSync()){
                      avatarFile.deleteSync();
                    }
                    await ContactDBWorker.db
                        .delete(inContactBean.id ?? 1);
                    Navigator.of(inAlertContext).pop();
                    ScaffoldMessenger.of(inAlertContext)
                        .showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                      content: Text(S.of(inContext).contact_list_alert_action_scaffold_content),
                    ));
                    ContactModel.contactModel
                        .loadData(Constant.contactDBTableName, ContactDBWorker.db);
                  },
                  child: Text(S.of(inContext).sure))
            ],
          );
        });
  }
}
