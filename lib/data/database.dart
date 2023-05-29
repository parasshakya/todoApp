import 'package:hive_flutter/hive_flutter.dart';

import '../model/todo.dart';

class ToDoDataBase {
  List<Todo> todos = [];
  List<Todo> completedTodos = [];
  List<Todo> runningTodos = [];
  List<Todo> postponedTodos = [];
  List<Todo> todoFound = [];



  // reference our box
  final _myBox = Hive.box('mybox');

  void addTodoItem(String todoText){
    todos.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todoText, isDone: false));
  }


}