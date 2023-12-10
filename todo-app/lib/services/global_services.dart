import "package:flutter/material.dart";
import "package:todo/ui/app_colors.dart";

var baseURL = "http://192.168.137.55/todo-app-api/Controllers/";
var profileBaseURL = "http://192.168.137.55/todo-app-api/uploads/";
// const String baseURL = "http://192.168.100.5/todo-app-api/Controllers/";
var headers = {"Accept": "application/json"};

errorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(message, style: const TextStyle(color: AppColors.whiteColor)),
    duration: const Duration(seconds: 2),
  ));
}

showSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text(message, style: const TextStyle(color: AppColors.whiteColor)),
    duration: const Duration(seconds: 2),
  ));
}

showCancelMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.orange,
    content: Text(message, style: const TextStyle(color: AppColors.whiteColor)),
    duration: const Duration(seconds: 2),
  ));
}
