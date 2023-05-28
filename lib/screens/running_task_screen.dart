import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';

import '../provider/todo_provider.dart';



class RunningTodoScreen extends StatefulWidget {
  const RunningTodoScreen({Key? key}) : super(key: key);

  @override
  State<RunningTodoScreen> createState() => _RunningTodoScreenState();
}

class _RunningTodoScreenState extends State<RunningTodoScreen> {
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
                      const Text('Running Todo\'s', style: TextStyle(fontSize: 32),),
                      const SizedBox(height: 20,),
                      Expanded(child:
                      Consumer<TodoListProvider>(
                        builder: (context, value, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TodoItem(todo: value.runningTodos[index], onTodoDelete: value.deleteRunningTodo, onTodoClick: _handleToDoChange,
                                menuVisible: false,);

                            }, itemCount: value.runningTodos.length,);
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
