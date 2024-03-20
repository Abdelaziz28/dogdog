import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration_screens_task1/screens/home_screen.dart';
import 'package:registration_screens_task1/screens/widgets/form.dart';
import 'package:window_manager/window_manager.dart';
import 'package:system_tray/system_tray.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WindowListener{
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/chattyCaps.png'),
        backgroundColor: Color(0xFF4E56A7),
      ),
      body: Container(
          height: screenHeight,
          width: screenWidth,
          child: CodeForm()),
      );
  }
}




