import 'package:flutter/material.dart';
import 'package:flutter_book/datebase/contact_db_worker.dart';
import 'package:flutter_book/models/contact_model.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_book/widget/contact_widget_list.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/constants.dart';
import 'contact_widget_entry.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({Key? key}) : super(key: key){

    ContactModel.contactModel.loadData(Constant.contactDBTableName, ContactDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dp),
      child: ScopedModel<ContactModel>(
        model: ContactModel.contactModel,
        child: ScopedModelDescendant<ContactModel>(
          builder: (BuildContext context, Widget? child, ContactModel model){
            return IndexedStack(
              index: model.stackIndex,
              children: [const ContactWidgetList(),ContactWidgetEntry()],
            );
          },
        ),
      ),
    );
  }
}
