import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'groups_widget_model.dart';

class GropsWidget extends StatelessWidget {
  const GropsWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _model =GroupsWidgetModel();
    return GroupsWidgetModelProvider(
        model:_model ,
        child:const _GroupWidgetBody()
    );
  }
}

class _GroupWidgetBody extends StatelessWidget {

  const _GroupWidgetBody({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Группы'),),
      body: _GropListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>GroupsWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}


class _GropListWidget extends StatelessWidget {
  const _GropListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupCount =
        GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupCount,
      separatorBuilder: (BuildContext context, int index){
        return const Divider(height: 1);
      },
      itemBuilder: (BuildContext context, int index){
        return  _GropListRowWidget(indexList: index);
      },

    );
  }
}

class _GropListRowWidget extends StatelessWidget {
  final int indexList;
  const _GropListRowWidget({Key? key, required this.indexList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexList];
    return Slidable(
      endActionPane:  ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>model.deleteGroup(indexList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(group.name) ,
        trailing:const Icon(Icons.chevron_right),
        onTap: () => GroupsWidgetModelProvider.read(context)?.model.showTasks(context,indexList),
      ),
    );
  }
}


