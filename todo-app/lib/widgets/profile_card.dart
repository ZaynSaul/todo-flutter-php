import 'package:flutter/material.dart';
import 'package:todo/services/global_services.dart';

class ProfileCard extends StatefulWidget {
  final String name;
  final String profile;
  const ProfileCard({super.key, required this.name, required this.profile});
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50.0)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: widget.profile.isEmpty
                      ? Image.asset(
                          "assets/images/profile.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          profileBaseURL + widget.profile,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ))),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  Text(widget.name,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ],
              )),
        ],
      ),
    );
  }
}
