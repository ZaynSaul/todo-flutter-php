// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/home.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/ui/app_colors.dart';

class UpdateName extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String userId;
  final index;

  const UpdateName(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      this.index});

  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  bool editMode = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  update() async {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Container(
              padding: const EdgeInsets.all(8.0),
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
            margin: const EdgeInsets.only(
              top: 20,
            ),
            child:Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.red, fontSize: 18))),
              const SizedBox(width: 20,),
              InkWell(
                  onTap: update,
                  child: const Text("Save",
                      style: TextStyle(color: Colors.black45, fontSize: 18))),
            ],
          ),),
        ],
      ),
    );
  }
}
