import 'package:flutter/material.dart';
import 'package:todo/screens/change_profile.dart';
import 'package:todo/ui/app_colors.dart';

class ProfileSettings extends StatefulWidget {
  
  final String name;
  final String email;
  final String password;
  final String profile;
  final String userId;
  final index;
  const ProfileSettings(
      {super.key,
      
      required this.name,
      required this.email,
      required this.password,
      required this.profile,
      required this.userId,
      this.index});
  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: AppColors.whiteColor,
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeProfile(
                        // todoId: widget.todoId,
                        // title: widget.title,
                        name: widget.name,
                        email: widget.email,
                        password: widget.password,
                        profile: widget.profile,
                        userId: widget.userId)));
          },
          leading: const Icon(
            Icons.person,
            size: 24,
            color: AppColors.primaryColor,
          ),
          title: const Text("Change Profile",
              style: TextStyle(color: Colors.black87, fontSize: 18)),
          trailing: const Icon(
            Icons.chevron_right,
            size: 24,
            color: Colors.grey,
          ),
        ));
  }
}
