import 'package:flutter/material.dart';
import 'package:todo_hive/domain/data_provider/hive_box_manager.dart';
import 'package:todo_hive/domain/entity/task.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  int groupKey;
  var _taskText = '';
  bool get isValid => _taskText.trim().isNotEmpty;

  set taskText(String value) {
    final isTaskEmpty =_taskText.trim().isEmpty;
    _taskText = value;
    if(value.trim().isEmpty != isTaskEmpty) {
        notifyListeners();
      }
  }

  TaskFormWidgetModel({
    required this.groupKey,
  });

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;
    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    box.add(task);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;

  const TaskFormWidgetModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, child: child,notifier: model);

  static TaskFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    throw false;
  }
}
