import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';


class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        tileColor: Colors.white,
        title: const Text('Todo1', style: TextStyle(fontSize: 25, decoration: TextDecoration.lineThrough),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: const Icon(Icons.check_box,color: tdBlue, size: 40,),
        contentPadding:const  EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tdRed,
          ),
          width: 35,
          height: 35,
          child: const Icon(Icons.delete,color: tdBgColor,),
        ),
      ),
    );
  }
}
