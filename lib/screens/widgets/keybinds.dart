import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';



class KeyboardListen extends StatefulWidget {

  @override
  State<KeyboardListen> createState() => _KeyboardListenState();

  const KeyboardListen(
      {super.key,
        required this.focusNode});

  final FocusNode focusNode;
}

class _KeyboardListenState extends State<KeyboardListen> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<KeybindSetter>(
      builder: (context, model, child) {
        return RawKeyboardListener(
          focusNode: widget.focusNode,
          autofocus: true,
          onKey: (event) {

          },
          child: Container(),
        );
      },
    );
  }
}


class KeybindSetter extends ChangeNotifier {
  LogicalKeyboardKey key1 = LogicalKeyboardKey.digit1;
  LogicalKeyboardKey key2 = LogicalKeyboardKey.digit2;
  LogicalKeyboardKey key3 = LogicalKeyboardKey.digit3;
  LogicalKeyboardKey key4 = LogicalKeyboardKey.digit4;

  void changeKey1(LogicalKeyboardKey newkey) {
    key1 = newkey;
    notifyListeners();
  }
  void changeKey2(LogicalKeyboardKey newkey) {
    key2 = newkey;
    notifyListeners();
  }
  void changeKey3(LogicalKeyboardKey newkey) {
    key3 = newkey;
    notifyListeners();
  }
  void changeKey4(LogicalKeyboardKey newkey) {
    key4 = newkey;
    notifyListeners();
  }
}