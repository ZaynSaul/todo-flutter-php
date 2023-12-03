// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/todo_list.dart';
import 'package:todo/screens/update_todo_item.dart';
import 'package:todo/services/global_services.dart';
// import 'package:todo/screens/todo_list.dart';

import 'package:todo/services/todo_item_service.dart';
import 'package:todo/ui/app_colors.dart';

class SubTodoItem extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String isDone;
  final String name;
  final String email;
  final String password;
  final String userId;
  final String todoId;
  final String todoTitle;
  final index;
  const SubTodoItem(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      required this.todoId,
      required this.todoTitle,
      this.index});

  @override
  _SubTodoItemState createState() => _SubTodoItemState();
}

class _SubTodoItemState extends State<SubTodoItem> {
  delete() async {
    http.Response response = await TodoItemServices.delete(widget.id);

    if (response.statusCode == 200) {
      navigateToTodoItem();
      Fluttertoast.showToast(
          msg: "Todo deleted successfully!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0);
    }
  }

  done(String isDone) async {
    http.Response response = await TodoItemServices.doneTodo(widget.id, isDone);

    if (response.statusCode == 200) {
      navigateToTodoItem();
      if (isDone == "1") {
        Fluttertoast.showToast(
            msg: "Todo item completed!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
      } else {
        showCancelMessage(context, "Todo item not completed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ListTile(
        onTap: () {
          navigateToUpdateTodoItem();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: AppColors.whiteColor,
        leading: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              if (widget.isDone == "1") {
                done('0');
              } else {
                done('1');
              }
            },
            color: AppColors.primaryColor,
            icon: widget.isDone == "1"
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
            iconSize: 18,
          ),
        ),
        title: Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  decoration:
                      widget.isDone == "1" ? TextDecoration.lineThrough : null),
            ),
            const Icon(Icons.edit, size: 20),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                  title: const Text('Message'),
                  content: const Text(
                    'Are you sure you want to delete this todo item?',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                  actions: <Widget>[
                    cancel(),
                    deleteConfirmation(),
                  ],
                ),
              );
            },
            color: AppColors.whiteColor,
            icon: const Icon(Icons.delete),
            iconSize: 18,
          ),
        ),
      ),
    );
  }

  void navigateToTodoItem() {
    final route = MaterialPageRoute(
      builder: (context) => TodoList(
          todoId: widget.todoId,
          title: widget.todoTitle,
          name: widget.name,
          email: widget.email,
          password: widget.password,
          userId: widget.userId),
    );
    Navigator.push(context, route);
    // Navigator.pop(context);
  }

  void navigateToUpdateTodoItem() {
    final route = MaterialPageRoute(
        builder: (context) => UpdateTodoItem(
            todoId: widget.todoId,
            todoTitle: widget.todoTitle,
            todoItemId: widget.id,
            todoItemTitle: widget.title,
            description: widget.description,
            name: widget.name,
            email: widget.email,
            password: widget.password,
            userId: widget.userId,
            index: widget.index));
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
      onPressed: delete,
      child: const Text(
        "Yes, delete",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
