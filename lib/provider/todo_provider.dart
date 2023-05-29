import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../model/todo.dart';

class TodoListProvider extends ChangeNotifier {
  List<Todo> _todos = [];
   List<Todo> _completedTodos = [];
   List<Todo> _runningTodos = [];
   List<Todo> _postponedTodos = [];
  List<Todo> _todoFound = [];

  List<Todo> get todos => _todos;

  List<Todo> get completedTodos => _completedTodos;

  List<Todo> get postponedTodos => _postponedTodos;

  List<Todo> get runningTodos => _runningTodos;

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

  //
  // void handleTodoClick(Todo todo){
  //   todo.isDone = !todo.isDone;
  //   notifyListeners();
  //
  // }


  void addCompletedTodo (BuildContext context, Todo completedTodo){
    if(_completedTodos.contains(completedTodo)){
      showSnackbar(context, 'Todo already added to completed tasks');
      return;
    }
    _completedTodos.add(completedTodo);
    notifyListeners();
    showSnackbar(context, 'Todo added to completed tasks');
  }




  void addRunningTodo(BuildContext context ,Todo runningTodo){
    if(_runningTodos.contains(runningTodo)){
      showSnackbar(context, "Todo already added to running tasks");
      return;
    }
    _runningTodos.add(runningTodo);
    notifyListeners();
    showSnackbar(context, 'Todo added to running tasks');

  }

  void addPostponedTodos(BuildContext context , Todo postponedTodo){
    if(_postponedTodos.contains(postponedTodo)){
      showSnackbar(context, "Todo already added to postponed tasks");
      return;
    }
    _postponedTodos.add(postponedTodo);
    notifyListeners();
    showSnackbar(context, "Todo added to postponed tasks");
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
    _todoFound = _todos;
    notifyListeners();

  }

  void deleteCompletedTodoItem(String id){
    _completedTodos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void deletePostponedTodo(String id){
    _postponedTodos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void deleteRunningTodo(String id){
    _runningTodos.removeWhere((element) => element.id == id);
    notifyListeners();
  }



  void showSnackbar(BuildContext context, String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger..removeCurrentSnackBar()..showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}