import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';


class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onDeleteItem;

  TodoItem({required this.todo,required this.onDeleteItem, required this.onTodoChanged});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: (){
          onTodoChanged(todo);
        },
        tileColor: Colors.white,
        title:  Text(todo.todoText, style: TextStyle(fontSize: 25, decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: todo.isDone ? const Icon(Icons.check_box,color: tdBlue, size: 40,) : const Icon(Icons.check_box_outline_blank,color: tdBlue, size: 40,),
        contentPadding:const  EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tdRed,
          ),
          width: 35,
          height: 35,
          child: InkWell(
            onTap: (){
              onDeleteItem(todo.id);
            },
              child:  Icon(Icons.delete,color: tdBgColor,)

          ),
        ),
      ),
    );
  }
}




