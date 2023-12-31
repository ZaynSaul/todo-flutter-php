// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/screens/login.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/ui/app_colors.dart';

class DrawerNavigation extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String profile;
  final String userId;

  const DrawerNavigation(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.profile,
      required this.userId});
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        backgroundColor: AppColors.secondaryColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(35.0),
                        child: widget.profile.isEmpty
                      ? Image.asset(
                          "assets/images/profile.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          profileBaseURL + widget.profile,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ))),
              ),
              accountName: Text(
                widget.name,
                style:
                    const TextStyle(color: AppColors.whiteColor, fontSize: 16),
              ),
              accountEmail: Text(widget.email,
                  style: const TextStyle(
                      color: AppColors.whiteColor, fontSize: 16)),
              decoration: const BoxDecoration(color: AppColors.primaryColor),
            ),
            ListTile(
              textColor: AppColors.primaryColor,
              leading: const Icon(
                Icons.home,
                color: AppColors.primaryColor,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                print("Home page");
              },
            ),
            ListTile(
              textColor: AppColors.primaryColor,
              leading: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.primaryColor,
              ),
              title: const Text(
                "About",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                print("About page");
              },
            ),
            ListTile(
              textColor: AppColors.primaryColor,
              leading: const Icon(
                Icons.settings,
                color: AppColors.primaryColor,
              ),
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Settings(
                            name: widget.name,
                            email: widget.email,
                            password: widget.password,
                            profile: widget.profile,
                            userId: widget.userId)));
                print("Setting page");
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                    (route) => false,
                  );
                  Fluttertoast.showToast(
                      msg: "You logged out successfully!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: AppColors.whiteColor,
                      fontSize: 16.0);
                  debugPrint("Logout");
                },
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.cyan,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.cyan),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
