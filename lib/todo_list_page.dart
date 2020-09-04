import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_list_model.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModel>(
      create: (_) => TodoListModel()..fetchLists(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO List'),
        ),
        body: Consumer<TodoListModel>(
          builder: (context, model, child) {
            final lists = model.lists;
            final listTiles = lists
                .map(
                  (list) => ListTile(
                    title: Text(list.title),
                  ),
                )
                .toList();
            return ListView(children: listTiles);
          },
        ),
      ),
    );
  }
}
