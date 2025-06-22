import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppConfig {
  static const String appName = 'Dog Soundboard';
  static const String version = '1.0.0';
  
  // Color scheme
  static const Color primaryColor = Color(0xFF4E56A7);
  static const Color accentColor = Color(0xFFF25D57);
  static const Color secondaryColor = Color(0xFFAF75FF);
  
  // Sound button configurations
  static const List<SoundButtonConfig> soundButtons = [
    SoundButtonConfig(
      id: '1',
      color: accentColor,
      imagePath: 'assets/images/butt.jpg',
      soundPath: 'sounds/fart1.wav',
      defaultKey: '1',
    ),
    SoundButtonConfig(
      id: '2',
      color: secondaryColor,
      imagePath: 'assets/images/smile.jpg',
      soundPath: 'sounds/bark1.wav',
      defaultKey: '2',
    ),
    SoundButtonConfig(
      id: '3',
      color: secondaryColor,
      imagePath: 'assets/images/butt2.jpg',
      soundPath: 'sounds/fart2.wav',
      defaultKey: '3',
    ),
    SoundButtonConfig(
      id: '4',
      color: accentColor,
      imagePath: 'assets/images/smile2.jpg',
      soundPath: 'sounds/bark2.wav',
      defaultKey: '4',
    ),
  ];

  static ThemeData get theme => ThemeData(
    fontFamily: 'Poppins',
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static Future<void> initializeWindow() async {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(900, 700),
      center: true,
      minimumSize: Size(500, 400),
      title: appName,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAlwaysOnTop(true);
    });
  }
}

class SoundButtonConfig {
  final String id;
  final Color color;
  final String imagePath;
  final String soundPath;
  final String defaultKey;

  const SoundButtonConfig({
    required this.id,
    required this.color,
    required this.imagePath,
    required this.soundPath,
    required this.defaultKey,
  });
}
