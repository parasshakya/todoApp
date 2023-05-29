import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';

import '../boxes.dart';
import '../provider/todo_provider.dart';



class RunningTaskScreen extends StatefulWidget {
  const RunningTaskScreen({Key? key}) : super(key: key);

  @override
  State<RunningTaskScreen> createState() => _RunningTaskScreenState();
}

class _RunningTaskScreenState extends State<RunningTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tdBgColor,

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                const Text('Running Todo\'s', style: TextStyle(fontSize: 32),),
                const SizedBox(height: 20,),
                Expanded(child:
                ValueListenableBuilder<Box<Todo>>(
                  valueListenable: Boxes.getRunningTodos().listenable(),
                  builder: (context, box, child) {
                    final todo = box.values.toList().cast<Todo>();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => TodoItem(todo: todo[index], onTodoDelete: (){}, onTodoClick: (){}),
                      itemCount: todo.length,
                    );
                  },

                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}
