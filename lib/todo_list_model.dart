import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class TodoListModel extends ChangeNotifier {
  List<Todo> lists = [];

  Future fetchLists() async {
    final docs = await FirebaseFirestore.instance.collection('lists').get();
    final lists = docs.docs.map((doc) => Todo(doc)).toList();
    this.lists = lists;
    notifyListeners();
  }

  Future deleteTodo(Todo todo) async {
    await FirebaseFirestore.instance
        .collection('lists')
        .doc(todo.documentID)
        .delete();
  }
}
