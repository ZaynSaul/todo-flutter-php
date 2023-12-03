import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo/screens/login.dart';



class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      )
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(colorScheme: const ColorScheme.light(), fontFamily: 'Nunito'),
      home: const Login(),
    );
  }
}