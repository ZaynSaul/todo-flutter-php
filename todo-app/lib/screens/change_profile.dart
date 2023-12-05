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
        body: Container(
          padding: EdgeInsets.all(8),
          height: double.infinity,
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
                                    showDialog(
                                      context: (context),
                                      builder: (context) => AlertDialog(
                                        title: const Text('Profile photo'),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [camera(), gallery()],
                                        ),
                                        actions: <Widget>[
                                          cancel(),
                                          done(),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.add_a_photo,
                                      color: AppColors.whiteColor, size: 35)),
                            )),
                      ),
                    ],
                  )
                ]),
          ),
        ));
  }

  Widget camera() {
    return Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
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
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.photo,
                  color: AppColors.whiteColor, size: 35)),
        ));
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

  Widget done() {
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
        "Done",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
