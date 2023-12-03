// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:todo/screens/home.dart';
import 'package:todo/screens/todo_list.dart';
import 'package:todo/screens/update_todo.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/ui/app_colors.dart';

class Todo extends StatefulWidget {
  final String id;
  final String title;
  final String isDone;
  final String name;
  final String email;
  final String password;
  final String userId;
  final index;

  const Todo(
      {super.key,
      required this.id,
      required this.title,
      required this.isDone,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      this.index});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  delete() async {
    http.Response response = await TodoServices.delete(widget.id);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
              name: widget.name,
              email: widget.email,
              password: widget.password,
              userId: widget.userId),
        ),
      );
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
    http.Response response = await TodoServices.doneTodo(widget.id, isDone);

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
              name: widget.name,
              email: widget.email,
              password: widget.password,
              userId: widget.userId),
        ),
      );
      Fluttertoast.showToast(
          msg: "Todo doned successfully!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0);
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TodoList(
                      todoId: widget.id,
                      title: widget.title,
                      name: widget.name,
                      email: widget.email,
                      password: widget.password,
                      userId: widget.userId)));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: AppColors.whiteColor,
        // leading: Container(
        //   padding: const EdgeInsets.all(0),
        //   margin: const EdgeInsets.symmetric(vertical: 12),
        //   width: 30,
        //   height: 30,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: IconButton(
        //     onPressed: () {
        // if(widget.isDone == "1"){
        //   done('0');
        // }else {
        //   done('1');
        // }
        //     },
        //     color: AppColors.primaryColor,
        // icon: widget.isDone == "1"
        //     ? const Icon(Icons.check_box)
        //     : const Icon(Icons.check_box_outline_blank),
        //     iconSize: 18,
        //   ),
        // ),

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateTodo(
                          todoId: widget.id,
                          todoTitle: widget.title,
                          name: widget.name,
                          email: widget.email,
                          password: widget.password,
                          userId: widget.userId,
                          index: widget.index)));
            },
            color: AppColors.primaryColor,
            icon: const Icon(Icons.edit),
            iconSize: 18,
          ),
        ),

        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const Icon(
            Icons.chevron_right,
            size: 30,
            color: Colors.grey,
          ),
        ),

        // trailing: Container(
        //   padding: const EdgeInsets.all(0),
        //   margin: const EdgeInsets.symmetric(vertical: 12),
        //   width: 35,
        //   height: 35,
        //   decoration: BoxDecoration(
        //     color: Colors.red,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: IconButton(
        //     onPressed: () {
        // showDialog(
        //   context: (context),
        //   builder: (context) => AlertDialog(
        //     title: const Text('Message'),
        //     content: const Text(
        //       'Are you sure you want to delete this todo?',
        //       style: TextStyle(
        //         color: Colors.red,

        //         fontSize: 18,
        //       ),
        //     ),
        //     actions: <Widget>[
        //       cancel(),
        //       deleteConfirmation(),
        //     ],
        //   ),
        // );
        //     },
        //     color: AppColors.whiteColor,
        //     icon: const Icon(Icons.delete),
        //     iconSize: 18,
        //   ),
        // ),
      ),
    );
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
