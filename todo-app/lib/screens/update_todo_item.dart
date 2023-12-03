// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print, prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:todo/screens/todo_list.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/todo_item_service.dart';
import 'package:todo/ui/app_colors.dart';

class UpdateTodoItem extends StatefulWidget {
  final String todoId;
  final String todoTitle;

  final String todoItemId;
  final String todoItemTitle;
  final String description;

  final String name;
  final String email;
  final String password;
  final String userId;
  final index;

  const UpdateTodoItem(
      {super.key,
      required this.todoId,
      required this.todoTitle,
      required this.todoItemId,
      required this.todoItemTitle,
      required this.description,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      this.index});

  @override
  _UpdateTodoItemState createState() => _UpdateTodoItemState();
}

class _UpdateTodoItemState extends State<UpdateTodoItem> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController todoIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  updateTodo() async {
    if (formKey.currentState!.validate()) {
      http.Response response = await TodoItemServices.update(
          widget.todoId,
          titleController.text,
          descriptionController.text,
          todoIdController.text);

      if (response.statusCode == 200) {
        navigateToTodItems();

        Fluttertoast.showToast(
            msg: "Todo updated successfully",
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
      titleController.text = widget.todoItemTitle;
      descriptionController.text = widget.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () => navigateToTodItems(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            minimumSize: const Size(40, 40),
            elevation: 0,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
            size: 25,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        elevation: 0,
        title: const Text("Edit Todo",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(
                  right: 10,
                  left: 10,
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
                  right: 10,
                  left: 10,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        padding: const EdgeInsets.all(20.0),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: updateTodo,
                    child: const Text(
                      "Update Data",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToTodItems() {
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
