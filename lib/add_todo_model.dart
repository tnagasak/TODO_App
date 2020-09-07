import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class AddTodoModel extends ChangeNotifier {
  String todoTitle = '';

  Future addTodoToFirebase() async {
    if (todoTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    FirebaseFirestore.instance.collection('lists').add(
      {
        'title': todoTitle,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateTodo(Todo todo) async {
    final document =
        FirebaseFirestore.instance.collection('lists').doc(todo.documentID);
    await document.update(
      {
        'title': todoTitle,
        'updatedAt': Timestamp.now(),
      },
    );
  }
}
