//to do のリストページ

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_todo_page.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/todo_list_model.dart';

//StatelessWidgetとchangeNotifierProviderを使ってモデルに変更があるごとに変化させる
class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModel>(
      create: (_) => TodoListModel()..fetchLists(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO List'),
        ),
        //ChangeNotifierProviderとConsumerはセットでとりあえず必要という認識
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
                    onLongPress: () async {
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${list.title}を削除しますか？'),
                            actions: <Widget>[
                              Row(
                                children: [
                                  FlatButton(
                                    child: Text('NO'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      //TODO: 削除のAPI
                                      await deleteTodo(context, model, list);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
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

  Future deleteTodo(
      BuildContext context, TodoListModel model, Todo todo) async {
    try {
      await model.deleteTodo(todo);
      await model.fetchLists();
    } catch (e) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
