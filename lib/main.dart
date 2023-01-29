import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_book/utils/dimen_fit.dart';
import 'package:flutter_book/utils/utils.dart';
import 'package:flutter_book/widget/appointment_widget.dart';
import 'package:flutter_book/widget/contact_widget.dart';
import 'package:flutter_book/widget/note_widget.dart';
import 'package:flutter_book/widget/task_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  //TODO:1.字体、布局适配
  startMeUp() async{
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    Directory docsDir = await getApplicationDocumentsDirectory();
    Utils.docsDir=docsDir;
    DimenFit.initialize();
    runApp(const FlutterBook());
  }
  startMeUp();
}

class FlutterBook extends StatelessWidget {
  const FlutterBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Book',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarOpacity: 0.8,
          toolbarHeight: 26.dp,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          bottom: TabBar(
            indicatorWeight: 2.0,
            tabs: [
              Tab(text: S.of(context).appointment, icon: const Icon(Icons.calendar_today)),
              Tab(text: S.of(context).contact, icon: const Icon(Icons.contact_page)),
              Tab(text: S.of(context).note, icon: const Icon(Icons.note)),
              Tab(text: S.of(context).task, icon: const Icon(Icons.task)),
            ],
          ),
        ),
        body: TabBarView(
          children: [AppointmentWidget(),ContactWidget(),NoteWidget(),TaskWidget()],
        ),
      ),
    );
  }

}
