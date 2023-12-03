import 'package:flutter/material.dart';
import 'package:todo/screens/change_profile.dart';
import 'package:todo/ui/app_colors.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: AppColors.whiteColor,
        child: ListTile(
          onTap: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChangeProfile()));
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
