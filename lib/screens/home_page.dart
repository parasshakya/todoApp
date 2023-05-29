import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/boxes.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/screens/completed_task_screen.dart';
import 'package:todoapp/screens/postponed_task_screen.dart';
import 'package:todoapp/screens/running_task_screen.dart';
import 'package:todoapp/widget/todo_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _todoController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: getDrawer(),
        backgroundColor: tdBgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: tdBgColor,
          foregroundColor: Colors.black,
        ),
        body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  searchBox(),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                      child: ValueListenableBuilder<Box<Todo>>(
                        valueListenable: Boxes.getTodos().listenable(),
                        builder: (context, box, child) {
                          final todo = box.values.toList().cast<Todo>();
                          return ListView.builder(
                              itemBuilder: (context, index) => TodoItem(todo: todo[index], onTodoDelete: (){}, onTodoClick: (){}),
                          itemCount: todo.length,
                          );
                        },

                      )
                      )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            )
                          ]),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                       addTodoItem(_todoController.text.trim());
                        _todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          minimumSize: const Size(60, 60),
                          elevation: 10),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                    )
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Container searchBox() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (todoText) {
            context.read<TodoListProvider>().searchTodoList(todoText);
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search...',
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }



  void _handleTodoClick(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  Drawer getDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
                child: Text(
                  'Progress Tracking',
                  style: TextStyle(fontSize: 30),
                )),
          ),
          ListTile(
            title: const Text('Completed Tasks'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompletedTaskScreen()));
            },
          ),
          ListTile(
            title: const Text('Running Tasks'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RunningTaskScreen()));            },
          ),
          ListTile(
            title: const Text('Postponed Tasks'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PostponedTaskScreen()));
            },
          ),
          // Add more ListTiles for additional items
        ],
      ),
    );
  }

  void addTodoItem(String todoText) {
    final todo = Todo(isDone: false, todoText: todoText, id: DateTime.now().millisecondsSinceEpoch.toString());
    final box = Boxes.getTodos();
    box.add(todo);

  }
}
