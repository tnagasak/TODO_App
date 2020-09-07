import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_todo_model.dart';
import 'package:todo_app/todo.dart';
import 'add_todo_model.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({this.todo});
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = todo != null;
    final textEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = todo.title;
    }

    return ChangeNotifierProvider<AddTodoModel>(
      create: (_) => AddTodoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? 'TODOを編集' : 'TODOを追加'),
        ),
        body: Consumer<AddTodoModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (text) {
                        model.todoTitle = text;
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? '変更する' : '追加する'),
                    onPressed: () async {
                      if (isUpdate) {
                        await updateTodo(model, context);
                      } else {
                        await addTodo(model, context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future addTodo(AddTodoModel model, BuildContext context) async {
    try {
      await model.addTodoToFirebase();

      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました'),
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
      Navigator.of(context).pop();
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

  Future updateTodo(AddTodoModel model, BuildContext context) async {
    try {
      await model.updateTodo(todo);

      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('変更しました'),
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
      Navigator.of(context).pop();
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
