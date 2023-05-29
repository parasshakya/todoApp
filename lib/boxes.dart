import 'package:hive/hive.dart';
import 'package:todoapp/model/todo.dart';

class Boxes{
  static Box<Todo> getTodos(){
    return Hive.box<Todo>('todos');
  }

  static Box<Todo> getCompletedTodos(){
    return Hive.box<Todo>("completedTodos");
  }

  static Box<Todo> getPostponedTodos(){
    return Hive.box<Todo>("postponedTodos");
  }

  static Box<Todo> getRunningTodos(){
    return Hive.box<Todo>("runningTodos");
  }
}