import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_hive/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {

  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_model == null){
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey:groupKey);
    }

  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if(model != null){
      return TasksWidgetModelProvider(
          model: model,
          child: const TasksWidgetBody()
      );
    }
    else {
      return const Center(child: CircularProgressIndicator());
    }

  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Задачи';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:const _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: taskCount,
      separatorBuilder: (BuildContext context, int index){
        return const Divider(height: 1);
      },
      itemBuilder: (BuildContext context, int index){
        return  _TaskListRowWidget(indexList: index);
      },

    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexList;
  const _TaskListRowWidget({Key? key, required this.indexList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexList];
    final icon = task.isDone ? Icons.done : null;
    final style = task.isDone ? const  TextStyle(decoration: TextDecoration.lineThrough) : null;

    return Slidable(
      endActionPane:  ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>model.deleteTask(indexList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          task.text,
          style: style,
        ) ,
        trailing: Icon(icon),
        onTap: () => model.doneToggle(indexList),
      ),
    );
  }
}
