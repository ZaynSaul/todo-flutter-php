// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/drawer/navigationdrawer.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/ui/app_colors.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/todo.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String userId;

  const HomeScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todoListData = [];
  showAllTodos() async {

    

    http.Response response = await TodoServices.view(widget.userId);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        todoListData = jsonData;
      });

      return jsonData;
    }
  }

  @override
  void initState() {
    super.initState();
    showAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            "Todos",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    fit: BoxFit.cover,
                  ))),
        ]),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: DrawerNavigation(
        name: widget.name,
        email: widget.email,
        password: widget.password,
        userId: widget.userId,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              searchBox(),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        "All Lists",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: (context),
                            builder: (context) => AlertDialog(
                              title: const Text('Message'),
                              content: const Text(
                                'Delete all Lists',
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
                        },
                        color: Colors.black87,
                        icon: const Icon(Icons.more_horiz),
                        iconSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: todoListData.length,
                    itemBuilder: (context, index) {
                      return Todo(
                        id: todoListData[index]['id'],
                        title: todoListData[index]['title'],
                        isDone: todoListData[index]['is_done'],
                        name: widget.name,
                        email: widget.email,
                        password: widget.password,
                        userId: widget.userId,
                        index: index,
                      );
                    }),
              ),
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AddTodo(
              name: widget.name,
              email: widget.email,
              password: widget.password,
              userId: widget.userId,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.primaryColor,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
              color: Colors.grey,
            )),
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
      onPressed: () {},
      child: const Text(
        "Yes, delete",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
