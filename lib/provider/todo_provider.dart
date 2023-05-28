
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

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



  void addCompletedTodo (Todo completedTodo){
    _completedTodos.add(completedTodo);
    notifyListeners();
  }

  void addRunningTodo(Todo runningTodo){
    _runningTodos.add(runningTodo);
    notifyListeners();
  }

  void addPostponedTodos(Todo postponedTodo){
    _postponedTodos.add(postponedTodo);
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
}