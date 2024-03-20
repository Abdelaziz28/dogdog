import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SoundButton extends StatefulWidget {
  const SoundButton(
      {super.key,
        required this.color,
        required this.dogy,
        required this.sound});

  final Color color;
  final String dogy;
  final String sound;

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => AudioPlayer().play(AssetSource(widget.sound)),
      child: Container(
        height: screenHeight * 0.22,
        width: screenWidth * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.color,
        ),
        child: Image.asset(widget.dogy),
      ),
    );
  }
}