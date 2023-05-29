import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject{
  
  @HiveField(0)
   String id;
  
  @HiveField(1)
   String todoText;
  
  @HiveField(2)
   bool isDone;

  Todo({required this.id, required this.isDone, required this.todoText});



}