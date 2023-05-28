import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';

import '../provider/todo_provider.dart';



class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
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
                Expanded(
                  child: ListView(
                    children: [
                      const Text('Completed Todo\'s', style: TextStyle(fontSize: 32),),
                      const SizedBox(height: 20,),
                      Expanded(child:
                      Consumer<TodoListProvider>(
                        builder: (context, value, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TodoItem(todo: value.completedTodos[index], onTodoDelete: value.deleteCompletedTodoItem, onTodoClick: _handleToDoChange,
                              menuVisible: false,);

                            }, itemCount: value.completedTodos.length,);
                        },
                      )
                      )
                    ],
                  ),
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
