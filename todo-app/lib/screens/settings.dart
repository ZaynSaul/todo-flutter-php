import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/ui/app_colors.dart';
import 'package:todo/widgets/password_settings.dart';
import 'package:todo/widgets/profile_settings.dart';
import 'package:todo/widgets/profile_card.dart';

class Settings extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String profile;
  final String userId;
  const Settings(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.profile,
      required this.userId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            minimumSize: const Size(40, 40),
            elevation: 0,
          ),
          onPressed: () => navigateToTodoHome(),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
            size: 25,
          ),
        ),
        title: const Text("Settings",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ProfileCard(name: widget.name, profile: widget.profile,),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.blue,
              height: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  ProfileSettings(
                      name: widget.name,
                      email: widget.email,
                      password: widget.password,
                      profile: widget.profile,
                      userId: widget.userId),
                  const SizedBox(height: 20),
                  PasswordSettings(
                      email: widget.email, password: widget.password),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   void  navigateToTodoHome(){
    final route = MaterialPageRoute(
            builder: (context) => HomeScreen(
                name: widget.name,
                email: widget.email,
                password: widget.password,
                profile: widget.profile,
                userId: widget.userId));
    Navigator.push(
          context,
          route
          
        );
  }
}
