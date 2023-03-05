import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/domain/entity/group.dart';
import 'package:todo_hive/domain/entity/task.dart';




class TaskFormWidgetModel{
  int groupKey;
  var taskText ='';

  TaskFormWidgetModel({
    required this.groupKey,
});

  void saveTask(BuildContext context) async{
    if(taskText.isEmpty)return;

    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    if(!Hive.isAdapterRegistered(2)){
      Hive.registerAdapter(TaskAdapter());
    }
    final tasksBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await tasksBox.add(task);

    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(tasksBox, task);
    Navigator.of(context).pop();
  }
}



class TaskFormWidgetModelProvider extends InheritedWidget{
  final TaskFormWidgetModel model;

  const TaskFormWidgetModelProvider ({Key? key, required Widget child,required this.model}):super(key: key,child: child);


  static TaskFormWidgetModelProvider? watch (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }
  static TaskFormWidgetModelProvider? read (BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    throw false;
  }

}