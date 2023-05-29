import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/provider/todo_provider.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function onTodoClick;
  final Function onTodoDelete;
  final bool menuVisible;

  TodoItem(
      {required this.todo,
      required this.onTodoDelete,
      required this.onTodoClick,
      this.menuVisible = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
          onTap: () {
            onTodoClick(todo);
          },
          tileColor: Colors.white,
          title: Text(
            todo.todoText,
            style: TextStyle(
                fontSize: 25,
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: todo.isDone
              ? const Icon(
                  Icons.check_box,
                  color: tdBlue,
                  size: 40,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: tdBlue,
                  size: 40,
                ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: tdRed,
                ),
                width: 35,
                height: 35,
                child: InkWell(
                    onTap: () {
                      onTodoDelete(todo.id);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: tdBgColor,
                    )),
              ),
              if (menuVisible)
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'completed',
                            child: const Text('completed'),
                            onTap: () {
                              context
                                  .read<TodoListProvider>()
                                  .addCompletedTodo(context, todo);
                            },
                          ),
                          PopupMenuItem(
                            value: 'in progress',
                            child: const Text('in progress'),
                            onTap: () {
                              context
                                  .read<TodoListProvider>()
                                  .addRunningTodo(context, todo);
                            },
                          ),
                          PopupMenuItem(
                            value: 'postpone',
                            child: const Text('postpone'),
                            onTap: () {
                              context
                                  .read<TodoListProvider>()
                                  .addPostponedTodos(context, todo);
                            },
                          ),
                        ],
                      ),
                    ))
            ],
          )),
    );
  }
}
