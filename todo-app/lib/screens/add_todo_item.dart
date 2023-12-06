// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print, prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:todo/screens/todo_list.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/todo_item_service.dart';
import 'package:todo/ui/app_colors.dart';

class AddTodoItem extends StatefulWidget {
  final String todoTitle;
  final String todoId;

  final String name;
  final String email;
  final String password;
  final String userId;
  final index;

  const AddTodoItem(
      {super.key,
      required this.todoTitle,
      required this.todoId,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      this.index});

  @override
  _AddTodoItemState createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  bool editMode = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController todoIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  addTodoItem() async {
    if (formKey.currentState!.validate()) {
      http.Response response = await TodoItemServices.add(
          titleController.text, descriptionController.text, widget.todoId);

      if (response.statusCode == 200) {
        navigateToAddTodoItem();

        Fluttertoast.showToast(
            msg: "Todo created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
      } else {
        errorSnackBar(context, "Something went wrong!");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      titleController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.whiteColor,
                border: InputBorder.none,
                hintText: "Enter title",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title filed is required';
                }

                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: descriptionController,
              maxLines: 3,
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Description area",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Description field is required";
                }
                if (value.trim().length < 5) {
                  return 'Description must be at least 10 characters in length';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.red, fontSize: 18))),
                InkWell(
                    onTap: addTodoItem,
                    child: const Text("Save",
                        style: TextStyle(color: Colors.black45, fontSize: 18))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAddTodoItem() {
    final route = MaterialPageRoute(
        builder: (context) => TodoList(
            todoId: widget.todoId,
            title: widget.todoTitle,
            name: widget.name,
            email: widget.email,
            password: widget.password,
            userId: widget.userId));
    Navigator.push(context, route);
  }
}
