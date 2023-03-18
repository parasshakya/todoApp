class Todo{
   String id;
   String todoText;
   bool isDone;

  Todo({required this.id, required this.isDone, required this.todoText});

  static List<Todo> todoList = [
    Todo(id: '1', isDone: true, todoText: 'Study at 10 am'),
    Todo(id: '2', isDone: false, todoText: 'Wash shoe'),
    Todo(id: '3', isDone: false, todoText: 'Bike servicing'),
    Todo(id: '4', isDone: false, todoText: 'Learn flutter'),
  ];

}