import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_book/beans/contact_bean.dart';
import 'package:flutter_book/datebase/contact_db_worker.dart';
import 'package:flutter_book/models/contact_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_book/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:path/path.dart';

import '../generated/l10n.dart';
import '../utils/constants.dart';
import '../utils/file_image_ex.dart';

class ContactWidgetEntry extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ContactWidgetEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //防止第一次启动时未设置entityBeingEdited报错
    if(ContactModel.contactModel.entityBeingEdited==null){
      ContactModel.contactModel.entityBeingEdited=ContactBean();
      ContactModel.contactModel.entityBeingEdited.birthday="";
      ContactModel.contactModel.setChosenDate(ContactModel.contactModel.entityBeingEdited.birthday);
    }

    return ScopedModel(
      model: ContactModel.contactModel,
      child: ScopedModelDescendant<ContactModel>(
        builder: (BuildContext inContext, Widget? inChild, ContactModel inModel){
          File avatarFile = File(join(Utils.docsDir.path,Constant.contactTempImageFileName));
          // if(avatarFile.existsSync()){
          //   avatarFile.readAsBytes().then((value) => print(value.length));
          // }
          if(avatarFile.existsSync()==false){
            if(inModel.entityBeingEdited.id!=null){
              avatarFile = File(join(Utils.docsDir.path,inModel.entityBeingEdited.id.toString()));
            }
          }
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.dp),
              child: Row(
                children: [
                  TextButton(
                    child: Text(S.of(inContext).cancel),
                    onPressed: (){
                      File avatarFile = File(join(Utils.docsDir.path,Constant.contactTempImageFileName));
                      if(avatarFile.existsSync()){
                        avatarFile.deleteSync();
                      }
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
                    title: avatarFile.existsSync() ? Image(image: FileImageEx(avatarFile),width: 50.dp,height: 50.dp,) : const Text("No avatar image for this contact"),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: (){
                        _selectAvatar(inContext);
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      initialValue: ContactModel.contactModel.entityBeingEdited.name,
                      decoration: InputDecoration(hintText: S.of(inContext).contact_entry_list_name_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).contact_entry_list_name_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        ContactModel.contactModel.entityBeingEdited.name=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: TextFormField(
                      keyboardType: TextInputType.phone,
                      initialValue: ContactModel.contactModel.entityBeingEdited.phone,
                      decoration: InputDecoration(hintText: S.of(inContext).contact_entry_list_phone_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).contact_entry_list_phone_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        ContactModel.contactModel.entityBeingEdited.phone=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: ContactModel.contactModel.entityBeingEdited.email,
                      decoration: InputDecoration(hintText: S.of(inContext).contact_entry_list_email_hint_text),
                      validator: (inValue){
                        if(inValue!=null&&inValue.isEmpty){
                          return S.of(inContext).contact_entry_list_email_validator;
                        }
                        return null;
                      },
                      onChanged: (value){
                        ContactModel.contactModel.entityBeingEdited.email=value;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.today),
                    title: Text(S.of(inContext).birthday),
                    subtitle: Text(ContactModel.contactModel.chosenDate??""),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        String chosenDate = await Utils.selectDateFormContact(inContext, ContactModel.contactModel, ContactModel.contactModel.entityBeingEdited.birthday);
                        if(chosenDate!=null&&chosenDate.isNotEmpty){
                          ContactModel.contactModel.entityBeingEdited.birthday= chosenDate;
                          //通知界面改变
                          ContactModel.contactModel.setChosenDate(chosenDate);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _selectAvatar(BuildContext inContext){
    return showDialog(context: inContext,
      builder: (BuildContext inDialogContext){
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(S.of(inContext).contact_entry_alert_library),
                onTap: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? cameraImage = await picker.pickImage(source: ImageSource.camera);
                  if(cameraImage!=null){
                    cameraImage.saveTo(join(Utils.docsDir.path,Constant.contactTempImageFileName));
                    ContactModel.contactModel.triggerRebuild();
                  }
                  Navigator.of(inDialogContext).pop();
                },
              ),
              SizedBox(
                height: 30.dp,
                child: const Divider(),
              ),
              GestureDetector(
                child: Text(S.of(inContext).contact_entry_alert_gallery),
                onTap: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? cameraImage = await picker.pickImage(source: ImageSource.gallery);
                  if(cameraImage!=null){
                    cameraImage.saveTo(join(Utils.docsDir.path,Constant.contactTempImageFileName));
                    ContactModel.contactModel.triggerRebuild();
                  }
                  Navigator.of(inDialogContext).pop();
                },
              )
            ],
          ),
        ),
      );
      }
    );
  }

  void _save(BuildContext inContext, ContactModel inModel) async {
    if(_formKey.currentState==null||!_formKey.currentState!.validate())return;

    int id=0;
    if(inModel.entityBeingEdited.id==null){
      id=await ContactDBWorker.db.create(ContactModel.contactModel.entityBeingEdited);
    }else{
      id=await ContactDBWorker.db.update(ContactModel.contactModel.entityBeingEdited);
    }

    File avatarFile = File(join(Utils.docsDir.path,Constant.contactTempImageFileName));
    if(avatarFile.existsSync()){
      avatarFile.renameSync(join(Utils.docsDir.path,id.toString()));
    }

    ContactModel.contactModel.loadData(Constant.contactDBTableName, ContactDBWorker.db);

    inModel.setStackIndex(0);

    ScaffoldMessenger.of(inContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          content: Text(S.of(inContext).contact_entry_save_scaffold_text),
        )
    );
  }


}
