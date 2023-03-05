import 'package:flutter/cupertino.dart';
import 'package:todo_hive/domain/entity/group.dart';
import 'package:todo_hive/widget/groups/groups_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/domain/entity/task.dart';


class GroupsWidgetModel extends ChangeNotifier{

  var _groups = <Group>[];

  List<Group> get groups =>_groups.toList();

  GroupsWidgetModel(){
    _setup();

  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/gropus/form');
  }

  void showTasks(BuildContext context, int groupIndex) async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(groupIndex) as int;

    Navigator.of(context).pushNamed('/groups/tasks',arguments: groupKey);
  }


  void deleteGroup(int groupIndex) async {
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
     await box.deleteAt(groupIndex);
  }

  void _readGroupsFromHive(Box<Group> box){
    _groups =  box.values.toList();
    notifyListeners();
  }

  void _setup() async{
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    if(!Hive.isAdapterRegistered(2)){
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>('tasks_box');
    _readGroupsFromHive(box);
    box.listenable().addListener(() => _readGroupsFromHive(box));
  }
}

class GroupsWidgetModelProvider extends InheritedNotifier{
  final GroupsWidgetModel model;

  const GroupsWidgetModelProvider ({Key? key, required Widget child,required this.model}):super(key: key,child: child,notifier: model);


  static GroupsWidgetModelProvider? watch (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }
  static GroupsWidgetModelProvider? read (BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }

}