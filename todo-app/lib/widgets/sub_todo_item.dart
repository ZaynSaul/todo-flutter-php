// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  final String profile;
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
      required this.profile,
      required this.userId,
      required this.todoId,
      required this.todoTitle,
      this.index});

  @override
  _SubTodoItemState createState() => _SubTodoItemState();
}

class _SubTodoItemState extends State<SubTodoItem> {
  delete(String id) async {
    http.Response response = await TodoItemServices.delete(id);

    if (response.statusCode == 200) {
      navigateToTodoItem();
      showSuccessMessage(context, "Todo item deleted successfully");
    }else{
      errorSnackBar(context, "Something went wrong!");
    }
  }

  done(String isDone) async {
    http.Response response = await TodoItemServices.doneTodo(widget.id, isDone);

    if (response.statusCode == 200) {
      navigateToTodoItem();
      if (isDone == "1") {
        showSuccessMessage(context, "Todo item is completed successfully");
      } else {
        showCancelMessage(context, "Todo item not completed");
      }
    }else{
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
          // A motion is a widget used to control how the pane animates.
          motion: const StretchMotion(),

          // A pane can dismiss the Slidable.
          

          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              onPressed: (context) => editTodoItem(),
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
              onPressed: (context) => _onDismissed(),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: ListTile(
        
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
                  ? const Icon(Icons.circle_rounded)
                  : const Icon(Icons.circle_outlined, ),
              iconSize: 20,
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
                    decoration: widget.isDone == "1"
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ],
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
      ),
    );
  }

  void _onDismissed() {
    delete(widget.id);
  }

  void navigateToTodoItem() {
    final route = MaterialPageRoute(
      builder: (context) => TodoList(
          todoId: widget.todoId,
          title: widget.todoTitle,
          name: widget.name,
          email: widget.email,
          password: widget.password,
           profile: widget.profile,
          userId: widget.userId),
    );
    Navigator.push(context, route);
    // Navigator.pop(context);
  }

  void editTodoItem() {
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
             profile: widget.profile,
            userId: widget.userId,
            index: widget.index));
    Navigator.push(context, route);
  }

 
}
