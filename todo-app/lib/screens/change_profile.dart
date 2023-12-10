// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:todo/services/global_services.dart';
import 'package:todo/services/upload_profile.dart';

import 'package:todo/ui/app_colors.dart';

class ChangeProfile extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String profile;
  final String userId;
  final index;

  const ChangeProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.profile,
      required this.userId,
      this.index});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  File? selectedImage;
  String? imageData;
  String? profileName;

  final ImagePicker _imagePicker = ImagePicker();
  //Gallery
  Future _pickImageFromGallery() async {
    final XFile? returnImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        imageData = base64Encode(selectedImage!.readAsBytesSync());
        profileName = returnImage.path.split('/').last;
      });
    }
    Navigator.of(context).pop(); //close the model sheet
  }

  //Camera
  Future _pickImageFromCamera() async {
    final XFile? photo =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        selectedImage = File(photo.path);
        imageData = base64Encode(selectedImage!.readAsBytesSync());
        profileName = photo.path.split('/').last;
      });
    }
    Navigator.of(context).pop();
  }

  uploadProfile() async {
    http.Response response =
        await UploadProfile.upload(profileName, imageData, widget.userId);

    if (response.statusCode == 200) {
      showSuccessMessage(context, "Profile uploaded successfully");
    } else {
      errorSnackBar(context, "Something went wrong!");
    }
  }

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
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: uploadProfile,
                            child: const Text("Done",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 18))),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(100.00)),
                          child: selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.file(
                                    selectedImage!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: widget.profile.isEmpty
                                      ? Image.asset(
                                          "assets/images/profile.jpg",
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          profileBaseURL + widget.profile,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
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
                            size: 30,
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
                            style:
                                TextStyle(color: Colors.black45, fontSize: 20)),
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
              onPressed: _pickImageFromCamera,
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
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo,
                  color: AppColors.whiteColor, size: 35)),
        ));
  }
}
