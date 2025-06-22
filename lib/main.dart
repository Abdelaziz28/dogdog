
import 'package:flutter/material.dart';
import 'package:dog_soundboard/screens/home_screen.dart';
import 'package:dog_soundboard/core/app_config.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initializeWindow();
  runApp(const DogSoundboard());
}

class DogSoundboard extends StatelessWidget {
  const DogSoundboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Soundboard',
      debugShowCheckedModeBanner: false,
      theme: AppConfig.theme,
      home: const HomeScreen(),
    );
  }
}


