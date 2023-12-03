import 'package:flutter/material.dart';
import 'package:todo/screens/change_password.dart';
import 'package:todo/ui/app_colors.dart';

class PasswordSettings extends StatefulWidget {
  final String email;
  final String password;
  const PasswordSettings(
      {super.key, required this.email, required this.password});

  @override
  _PasswordSettingsState createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
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
                    builder: (context) => ChangePassword(
                        email: widget.email, password: widget.password)));
          },
          leading: const Icon(
            Icons.settings,
            size: 24,
            color: Colors.amber,
          ),
          title: const Text("Change Password",
              style: TextStyle(color: Colors.black87, fontSize: 18)),
          trailing: const Icon(
            Icons.chevron_right,
            size: 24,
            color: Colors.grey,
          ),
        ));
  }
}
