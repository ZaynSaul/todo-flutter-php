import 'package:flutter/material.dart';


class ProfileCard extends StatefulWidget {
  final String name;
  const ProfileCard({super.key, required this.name});
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
                    color: Colors.grey,
                    width: 1,
                    style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(50.0)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    "assets/images/profile.jpg",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ))),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  Text("Software Engineer",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.w500))
                ],
              )),
        ],
      ),
    );
  }
}
