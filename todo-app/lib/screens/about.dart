import 'package:flutter/material.dart';
import 'package:todo/ui/app_colors.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          elevation: 0,
        ),
        body: Container(
            child: Column(children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text("About Todo",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text("This is meant for taking care of your daily todos.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
              ),
        ])));
  }
}
