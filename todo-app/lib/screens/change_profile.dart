import 'package:flutter/material.dart';
import 'package:todo/ui/app_colors.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        elevation: 0,
        title: const Text("Upload Profile",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  )),
              Positioned(
                bottom: -4,
                right: 20,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_a_photo,
                        color: Colors.black45, size: 35)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
