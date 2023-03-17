import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
        body: Center(
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
                      TodoItem(),
                      TodoItem(),
                      TodoItem(),
                      TodoItem(),
                      TodoItem(),
                      TodoItem(),
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

  Container searchBox() {
    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child:  const Padding(
                  padding:  EdgeInsets.all(10.0),
                  child:  TextField(

                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',

                      icon: Icon(Icons.search),

                    ),

                  ),
                ),
              );
  }
}
