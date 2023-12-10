// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/drawer/navigationdrawer.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/todo_service.dart';
import 'package:todo/ui/app_colors.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/spinner_screen.dart';
import 'package:todo/widgets/todo.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String profile;
  final String userId;

  const HomeScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.profile,
      required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSearch = false;
  late bool _isLoading = false;
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
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    _showSearch = false;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.00)),
                child: Center(
                  child: GestureDetector(
                      onTap: () {},
                      child: Badge.count(
                          count: 3,
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.notifications,
                              color: AppColors.primaryColor, size: 24))),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.00)),
                child: Center(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _showSearch = true;
                          });
                        },
                        icon: const Icon(Icons.search_rounded,
                            color: Colors.grey, size: 24))),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  profileSettings();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.00)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: widget.profile.isEmpty ? Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.cover,
                    ) : Image.network(profileBaseURL+widget.profile, fit: BoxFit.cover,),
                  ),
                ),
              ),
            ],
          ),
        ]),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: DrawerNavigation(
        name: widget.name,
        email: widget.email,
        password: widget.password,
        profile: widget.profile,
        userId: widget.userId,
      ),
      body: _isLoading
          ? const LoadingScreen()
          : todoListData.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            searchBox(),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(0),
                                    
                                    child: Center(
                                      child: IconButton(
                                        alignment: Alignment.center,
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
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              cancel(),
                                              deleteConfirmation(),
                                            ],
                                          ),
                                        );
                                      },
                                      mouseCursor: MouseCursor.defer,
                                      color: Colors.black87,
                                      icon: const Icon(Icons.more_horiz_rounded),
                                      iconSize: 28,
                                    ),
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
                                      profile: widget.profile,
                                      userId: widget.userId,
                                      index: index,
                                    );
                                  }),
                            ),
                          ]),
                    ),
                  ],
                )
              : noTask(),
      floatingActionButton: floatingButtion(),
    );
  }

  Widget floatingButtion() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        showAddNewList(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  void showAddNewList(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (bulder) {
          return Container(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Add new list",
                      style: TextStyle(color: Colors.black45, fontSize: 20)),
                  const SizedBox(height: 20),
                  AddTodo(
                    name: widget.name,
                    email: widget.email,
                    password: widget.password,
                    profile: widget.profile,
                    userId: widget.userId,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget noTask() {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  "assets/images/No_Task_List.png",
                  fit: BoxFit.cover,
                )),
            const Text("No todo list", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    if (_showSearch == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.primaryColor,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _showSearch = false;
                });
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
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

  void profileSettings() {
    final route = MaterialPageRoute(
      builder: (context) => Settings(
          name: widget.name,
          email: widget.email,
          password: widget.password,
          profile: widget.profile,
          userId: widget.userId),
    );
    Navigator.push(context, route);
  }
}
