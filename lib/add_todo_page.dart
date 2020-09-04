import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add_todo_model.dart';

class AddTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTodoModel>(
      create: (_) => AddTodoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODOを追加'),
        ),
        body: Consumer<AddTodoModel>(
          builder: (context, model, child) {
            return Container();
          },
        ),
      ),
    );
  }
}
