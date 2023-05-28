import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';

import '../provider/todo_provider.dart';



class PostponedTodoScreen extends StatefulWidget {
  const PostponedTodoScreen({Key? key}) : super(key: key);

  @override
  State<PostponedTodoScreen> createState() => _PostponedTodoScreenState();
}

class _PostponedTodoScreenState extends State<PostponedTodoScreen> {
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
                      const Text('Postponed Todo\'s', style: TextStyle(fontSize: 32),),
                      const SizedBox(height: 20,),
                      Expanded(child:
                      Consumer<TodoListProvider>(
                        builder: (context, value, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TodoItem(todo: value.postponedTodos[index], onTodoDelete: value.deletePostponedTodo, onTodoClick: _handleToDoChange,
                                menuVisible: false,);

                            }, itemCount: value.postponedTodos.length,);
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
