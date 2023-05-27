
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';

class TodoListProvider extends ChangeNotifier {
  List<Todo> _todos = [];
   List<Todo> _completedTodos = [];
  List<Todo> _todoFound = [];

  List<Todo> get todos => _todos;

  List<Todo> get completedTodos => _completedTodos;

  List<Todo> get todoFound => _todoFound;

  void searchTodoList(String searchWord){
    List<Todo> results = [];
    if(searchWord.isEmpty){
      results = _todos;
    }else{
      results = _todos.where((todo) => todo.todoText.toLowerCase().contains(searchWord.toLowerCase()) ).toList();
    }
    _todoFound = results;

    notifyListeners();
  }

  void setFoundTodoList(List<Todo> todoList){
    _todoFound = todoList;
    notifyListeners();
  }


  void addCompletedTodo (Todo completedTodo){
    completedTodos.add(completedTodo);
    notifyListeners();
  }


  void deleteTodoItem(String id) {
    _todos.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addTodoItem(String todoText) {
    _todos.add(Todo(id: DateTime
        .now()
        .millisecondsSinceEpoch
        .toString(), isDone: false, todoText: todoText));
    notifyListeners();
  }
}