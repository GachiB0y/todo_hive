import 'package:flutter/material.dart';
import 'package:todo_hive/widget/grop_form/grop_form_widget_model.dart';

class GroupFromWidget extends StatefulWidget {
  const GroupFromWidget({Key? key}) : super(key: key);

  @override
  State<GroupFromWidget> createState() => _GroupFromWidgetState();
}

class _GroupFromWidgetState extends State<GroupFromWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
      model:_model,
        child: const _GroupFormWidgetBody()
    );
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;

    return Scaffold(
      appBar: AppBar(title:const Text('Новая группа'),),
      body: Center(child:
      Container(
        child:const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child:  _GroupNameWidget(),
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.saveGroup(context),
        child: Icon(Icons.done),
      ),
    );
  }
}


class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.read(context)?.model;
    return TextField(
      textCapitalization: TextCapitalization.words,
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText:'Введите имя гупппы',
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete:() => model?.saveGroup(context),
    );
  }
}
