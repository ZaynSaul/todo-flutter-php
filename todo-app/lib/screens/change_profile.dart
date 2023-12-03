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
        
        backgroundColor: const Color(0xfff5f6f8),
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        elevation: 0,
        title: const Text("Chnage Password",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        centerTitle: true,
      ),
      
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_a_photo,
                        color: Colors.black45, size: 24)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
