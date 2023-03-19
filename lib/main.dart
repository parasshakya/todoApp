import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> _foundTodo = [];
  final todoList = Todo.todoList;

  final _todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _foundTodo = todoList;
    super.initState();
  }

  void _runFilter(String enteredKeyword){
    List<Todo> results = [];
    if(enteredKeyword.isEmpty){
      results = todoList;

    }else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: tdBgColor,

       appBar: AppBar(
         elevation: 0,
         backgroundColor: tdBgColor,
         title: Row(children: const [
           Icon(Icons.menu, color: Colors.black,),
         ],),
       ),
        body: Stack(
         children:[
           Center(
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   searchBox(),
                   SizedBox(height: 30,),
                   Expanded(
                     child: ListView(
                       children: [
                         Text('All Todo\'s', style: TextStyle(fontSize: 32),),
                         SizedBox(height: 20,),
                         for(Todo todo in _foundTodo.reversed)
                           TodoItem(
                             todo: todo,
                             onDeleteItem: _handleDeleteItem,
                             onTodoChanged: _handleToDoChange,
                         ),

                       ],
                     ),
                   )
                 ],
               ),
             ),
           ),
           Align(alignment: Alignment.bottomCenter,
           child: Row(
             children: [
               Expanded(
                 child: Container(
                   margin: EdgeInsets.only(bottom: 20,right: 20, left: 20),
                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius:  BorderRadius.circular(8),
                     boxShadow:  const [
                        BoxShadow(
                         color: Colors.grey,
                         offset: Offset(0,0),
                         blurRadius: 10.0,
                         spreadRadius: 0.0,
                       )
                     ]
                   ),
                   child:  TextField(
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
                   onPressed: (){
                     _addTodoItem(_todoController.text.trim());
                   },
                   child:  Text('+', style: TextStyle(fontSize: 40),),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: tdBlue,
                     minimumSize: Size(60,60),
                     elevation: 10
                   ),

                 ),
               )

             ],
           ),
           )

         ]
        ),
      ),
    );
  }

  Container searchBox() {
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child:   Padding(
                  padding:  EdgeInsets.all(10.0),
                  child:  TextField(
                    onChanged: (value) {
                       _runFilter(value);
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

  void _handleToDoChange(Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todoText){
  setState(() {
    todoList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), isDone: false, todoText: todoText));

  });
  _todoController.clear();

  }
}
