import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main_model.dart';
import 'package:todo_app/todo_list_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String kboyText = 'Nagasakiじゃない';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
      ),
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('TODO List'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      model.kboyText,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    RaisedButton(
                      child: Text('ボタン'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TodoListPage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // todo
            },
          ),
        ),
      ),
    );
  }
}
