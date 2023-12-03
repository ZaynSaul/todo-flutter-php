// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo/services/auth_service.dart';
import 'package:todo/services/global_services.dart';

import 'package:todo/ui/app_colors.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  final String password;
  const ChangePassword(
      {super.key, required this.email, required this.password});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  bool obserText = true;

  Future changePassword() async {
    if (formKey.currentState!.validate()) {
      http.Response response = await AuthServices.changePassword(
          widget.email, widget.password, newPasswordController.text);

      if (response.statusCode == 200) {
        var userData = json.decode(response.body);

        if (userData == "THE_SAME") {
          errorSnackBar(
              context, "New password must be different from old password");
        } else {
          Navigator.pop(context);

          Fluttertoast.showToast(
              msg: "logged in successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: AppColors.whiteColor,
              fontSize: 20.0);
        }
      } else {
        errorSnackBar(context, "Something went wrong!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        elevation: 0,
        title: const Text("Change Password",
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
                  bottom: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: newPasswordController,
                  obscureText: obserText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    border: InputBorder.none,
                    hintText: "Enter new password",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obserText = !obserText;
                        });
                      },
                      child: Icon(
                        obserText == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password field is required";
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters in length';
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
                    onPressed: changePassword,
                    child: const Text(
                      "Update Password",
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

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
