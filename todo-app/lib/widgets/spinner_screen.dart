import 'package:flutter/material.dart';
import 'package:todo/ui/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: const Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    ));
  }
}
