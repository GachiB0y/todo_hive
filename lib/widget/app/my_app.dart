
import 'package:flutter/material.dart';
import 'package:todo_hive/task_from/task_form_widget.dart';
import 'package:todo_hive/tasks/tasks_widget.dart';
import 'package:todo_hive/widget/example/example_widget.dart';
import 'package:todo_hive/widget/grop_form/grop_form_widget.dart';

import '../groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo+Hive',
      routes:{
        '/groups' :(context) => const GropsWidget(),
        '/gropus/form':(context) => const GroupFromWidget(),
        '/groups/tasks' :(context) => const TasksWidget(),
        '/groups/tasks/form' :(context) => const TaskFormWidget(),

      } ,
      initialRoute:'/groups' ,
      theme:ThemeData(
          primarySwatch: Colors.blue,
      ) ,
    );
  }
}
