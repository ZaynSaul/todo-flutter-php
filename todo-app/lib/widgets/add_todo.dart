// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/home.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/ui/app_colors.dart';

class AddTodo extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String userId;
  final index;

  const AddTodo(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      this.index});

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  bool editMode = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  addTodo() async {
    if (formKey.currentState!.validate()) {
      http.Response response =
          await TodoServices.add(titleController.text, widget.userId);

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
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: const EdgeInsets.only(
                bottom: 20,
                right: 10,
                left: 20,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo ',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: titleController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title filed is required';
                  }

                  return null;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              onPressed: addTodo,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(40, 40),
                elevation: 10,
              ),
              child: const Text(
                '+',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
