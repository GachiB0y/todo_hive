import 'package:todo_hive/ui/widget/grop_form/grop_form_widget.dart';
import 'package:todo_hive/ui/widget/groups/groups_widget.dart';
import 'package:todo_hive/ui/widget/task_from/task_form_widget.dart';
import 'package:todo_hive/ui/widget/tasks/tasks_widget.dart';
import 'package:flutter/material.dart';

class MainNavigationRoutesNames {
  static const groups = '/';
  static const groupsForm = '/gropusForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNaviagtion {
  final initialRoute = MainNavigationRoutesNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesNames.groups: (context) => const GropsWidget(),
    MainNavigationRoutesNames.groupsForm: (context) => const GroupFromWidget(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesNames.tasks:
        final configuration = settings.arguments as TasksWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context) => TasksWidget(
            configuration: configuration,
          ),
        );
      case MainNavigationRoutesNames.tasksForm:
        final configuration = settings.arguments as TasksWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context) => TaskFormWidget(
            groupKey: configuration.groupKey,
          ),
        );
      default:
        const widget = Text('Navigation Error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
