import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/screens/home_page.dart';
import 'package:hive/hive.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

   Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>("todos");
  await Hive.openBox<Todo>("completedTodos");
  await Hive.openBox<Todo>("runningTodos");
  await Hive.openBox<Todo>("postponedTodos");

  runApp(ChangeNotifierProvider(
      create: (_) => TodoListProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
