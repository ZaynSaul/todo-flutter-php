// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:todo/screens/home.dart';
import 'package:todo/screens/todo_list.dart';
import 'package:todo/screens/update_todo.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/ui/app_colors.dart';

class Todo extends StatefulWidget {
  final String id;
  final String title;
  final String isDone;
  final String name;
  final String email;
  final String password;
  final String profile;
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
      required this.profile,
      required this.userId,
      this.index});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  delete(String id) async {
    http.Response response = await TodoServices.deleteList(id);

    if (response.statusCode == 200) {
      navigateToTodoHome();
      showSuccessMessage(context, "Todo list deleted successfully");
    } else {
      errorSnackBar(context, "Something went wrong!");
    }
  }

  done(String isDone) async {
    http.Response response = await TodoServices.doneTodo(widget.id, isDone);

    if (response.statusCode == 200) {
      navigateToTodoHome();
      if (isDone == "1") {
        showSuccessMessage(context, "Todo item is completed successfully");
      } else {
        showCancelMessage(context, "Todo item not completed");
      }
    } else {
      errorSnackBar(context, "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Slidable(
          key: ValueKey(widget.id),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context) => viewListItem(),
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.visibility_outlined,
              ),
              SlidableAction(
                onPressed: (context) => editTodo(),
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              delete(widget.id);
            }),
            children: [
              SlidableAction(
                onPressed: (context) => deleteComfirmationModal(),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
            ],
          ),
          child: ListTile(
            onTap: () => viewListItem(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            // contentPadding:
            //     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: AppColors.whiteColor,
            leading: Container(
              padding: const EdgeInsets.all(0),
              width: 30,
              height: 30,
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
                    ? const Icon(
                        Icons.circle_rounded,
                      )
                    : const Icon(Icons.circle_outlined),
                iconSize: 20,
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  decoration:
                      widget.isDone == "1" ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(0),
              child: widget.isDone == "1"
                  ? const Icon(
                      Icons.check_rounded,
                      size: 24,
                      color: Colors.green,
                    )
                  : const Text(""),
            ),
          ),
        ));
  }

  void _onDismissed() {
    delete(widget.id);
  }

  void viewListItem() {
    final route = MaterialPageRoute(
        builder: (context) => TodoList(
            todoId: widget.id,
            title: widget.title,
            name: widget.name,
            email: widget.email,
            password: widget.password,
            profile: widget.profile,
            userId: widget.userId));
    Navigator.push(context, route);
  }

  void editTodo() {
    final route = MaterialPageRoute(
        builder: (context) => UpdateTodo(
            todoId: widget.id,
            todoTitle: widget.title,
            name: widget.name,
            email: widget.email,
            password: widget.password,
            profile: widget.profile,
            userId: widget.userId,
            index: widget.index));
    Navigator.push(context, route);
  }

  void navigateToTodoHome() {
    final route = MaterialPageRoute(
        builder: (context) => HomeScreen(
            name: widget.name,
            email: widget.email,
            password: widget.password,
            profile: widget.profile,
            userId: widget.userId));
    Navigator.push(context, route);
  }

  void deleteComfirmationModal() {
    showDialog(
      context: (context),
      builder: (context) => AlertDialog(
        title: const Text('Message'),
        content: const Text(
          'Delete todo list',
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
      onPressed: () => _onDismissed(),
      child: const Text(
        "Yes, delete",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
