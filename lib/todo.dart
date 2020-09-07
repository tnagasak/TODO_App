import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc.data()['title'];
  }

  String documentID;
  String title;
}
