import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:todo/screens/add_todo_item.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/services/todo_item_service.dart';
import 'package:todo/ui/app_colors.dart';
import 'package:todo/widgets/spinner_screen.dart';
import 'package:todo/widgets/sub_todo_item.dart';

class TodoList extends StatefulWidget {
  final String todoId;
  final String title;

  final String name;
  final String email;
  final String password;
  final String userId;

  const TodoList(
      {super.key,
      required this.todoId,
      required this.title,
      required this.name,
      required this.email,
      required this.password,
      required this.userId});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late bool _isLoading = false;
  List todoItemListData = [];
  List countTodoItemListData = [];
  showAllTodoItems() async {
    http.Response response = await TodoItemServices.view(widget.todoId);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        todoItemListData = jsonData;
      });

      return jsonData;
    }
  }

  countTodoItems() async {
    http.Response response =
        await TodoItemServices.countTodoItem(widget.todoId);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        countTodoItemListData = jsonData;
      });

      return jsonData;
    }
  }

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
    showAllTodoItems();
    countTodoItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: appBar(),
      body: _isLoading
          ? const LoadingScreen()
          : todoItemListData.isNotEmpty
              ? Stack(children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                              bottom: 10,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Completed(${countTodoItemListData.length})",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(0),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: (context),
                                        builder: (context) => AlertDialog(
                                          title: const Text('Message'),
                                          content: const Text(
                                            'Delete all completed todo items',
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            cancel(),
                                            deleteConfirmation(),
                                          ],
                                        ),
                                      );
                                    },
                                    color: Colors.black87,
                                    icon: const Icon(Icons.more_horiz),
                                    iconSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: todoItemListData.length,
                                itemBuilder: (context, index) {
                                  return SubTodoItem(
                                    id: todoItemListData[index]['id'],
                                    title: todoItemListData[index]['title'],
                                    description: todoItemListData[index]
                                        ['description'],
                                    isDone: todoItemListData[index]['is_done'],
                                    name: widget.name,
                                    email: widget.email,
                                    password: widget.password,
                                    userId: widget.userId,
                                    todoId: widget.todoId,
                                    todoTitle: widget.title,
                                    index: index,
                                  );
                                }),
                          ),
                        ]),
                  ),
                ])
              : noTask(),
      floatingActionButton: floatingButtion(),
    );
  }

  Widget floatingButtion() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: navigateToAddTodo,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget noTask() {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  "assets/images/goals.png",
                  fit: BoxFit.cover,
                )),
            const Text("No To Do item", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  void navigateToAddTodo() {
    final route = MaterialPageRoute(
        builder: (context) => AddTodoItem(
            todoId: widget.todoId,
            todoTitle: widget.title,
            name: widget.name,
            email: widget.email,
            password: widget.password,
            userId: widget.userId));
    Navigator.push(context, route);
  }

  Widget cancel() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.all(10.0),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      onPressed: () {
        Navigator.pop(context);
        setState(() {});
      },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget deleteConfirmation() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.all(10.0),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      onPressed: () {},
      child: const Text(
        "Yes, delete",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      iconTheme: const IconThemeData(color: AppColors.primaryColor),
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          minimumSize: const Size(40, 40),
          elevation: 0,
        ),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(
                name: widget.name,
                email: widget.email,
                password: widget.password,
                userId: widget.userId))),
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
          size: 25,
        ),
      ),
      title: Text(widget.title,
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87)),
      elevation: 0,
      centerTitle: true,
    );
  }
}
