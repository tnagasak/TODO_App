import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_todo_page.dart';
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
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTodoPage(
                              todo: list,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchLists();
                      },
                    ),
                  ),
                )
                .toList();
            return ListView(children: listTiles);
          },
        ),
        floatingActionButton:
            Consumer<TodoListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchLists();
            },
          );
        }),
      ),
    );
  }
}
