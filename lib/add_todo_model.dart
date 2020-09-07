import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class AddTodoModel extends ChangeNotifier {
  String todoTitle = '';

  Future addTodoToFirebase() async {
    //例外時の処理
    if (todoTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }

    //Firebaseに値を追加する時の処理
    FirebaseFirestore.instance.collection('lists').add(
      {
        'title': todoTitle,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateTodo(Todo todo) async {
    //例外時の処理
    if (todoTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }

    //documentIDのデータをとってきて変数に代入
    final document =
        FirebaseFirestore.instance.collection('lists').doc(todo.documentID);
    //データ更新時の処理
    await document.update(
      {
        'title': todoTitle,
        'updatedAt': Timestamp.now(),
      },
    );
  }
}
