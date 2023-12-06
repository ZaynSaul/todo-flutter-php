import 'package:flutter/material.dart';
import 'package:todo/ui/app_colors.dart';

class ChangeProfile extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String userId;
  final index;

  const ChangeProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.userId,
      this.index});

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
        body: Container(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(100.00)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.asset(
                                "assets/images/profile.jpg",
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ))),
                      Positioned(
                        bottom: 4,
                        right: 20,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  showImagePicker(context);
                                },
                                icon: const Icon(Icons.add_a_photo,
                                    color: AppColors.whiteColor, size: 35)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: AppColors.secondaryColor,
                    width: double.infinity,
                    height: 100,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    child: ListView(
                      children: [
                        ListTile(
                          textColor: Colors.black45,
                          leading: const Icon(
                            Icons.account_circle,
                            color: Colors.black45,
                          ),
                          title: const Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black45,
                            ),
                          ),
                          subtitle: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        const Divider(
                            indent: 70,
                            height: 5,
                            color: Colors.grey,
                            thickness: 0.5),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (bulder) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                        const Text("Profile photo",
                            style: TextStyle(
                                color: Colors.black45, fontSize: 20)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [camera(), gallery()],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18))),
                            InkWell(
                                onTap: () {},
                                child: const Text("Save",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 18))),
                          ],
                        ),
                      ])));
        });
  }

  Widget camera() {
    return Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined,
                  color: AppColors.whiteColor, size: 35)),
        ));
  }

  Widget gallery() {
    return Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.photo,
                  color: AppColors.whiteColor, size: 35)),
        ));
  }
}
