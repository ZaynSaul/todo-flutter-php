// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/home.dart';
import 'package:todo/screens/login.dart';
import 'package:todo/services/auth_service.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/ui/app_colors.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obserText = true;

  register() async {
    if (formKey.currentState!.validate()) {
      http.Response response =
          await AuthServices.register(name.text, email.text, password.text);

      if (response.statusCode == 200) {
        var userData = json.decode((response.body));

        if (userData == "TAKEN") {
          errorSnackBar(context, "This account is already taken, try another!");
        } else if (userData == "FAILED") {
          errorSnackBar(context, "Registration failed try again!");
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                  name: userData['name'],
                  email: userData['email'],
                  password: userData['password'],
                   profile: userData['profile'],
                  userId: userData['id']),
            ),
          );

          Fluttertoast.showToast(
              msg: "logged in successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: AppColors.whiteColor,
              fontSize: 20.0);

          print(userData);
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical:20.0),
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    hintText: "Enter Full Name",
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name filed is required';
                    }
                    if (RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                      return "Please enter full name";
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    hintText: "Email or Email",
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.primaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email filed is required';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  controller: password,
                  obscureText: obserText,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    hintText: "Password",
                    hintStyle: const TextStyle(color: AppColors.primaryColor),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.red,
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
                    border: InputBorder.none,
                  ),
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
                        ),
                        ),
                    onPressed: register,
                    child: const Text(
                      "Register",
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already having an account? ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
