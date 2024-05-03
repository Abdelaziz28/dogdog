import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keylistener/keylistener_platform_interface.dart';
import 'package:registration_screens_task1/screens/widgets/slider.dart';
import 'package:registration_screens_task1/screens/widgets/sound_button.dart';
import 'package:window_manager/window_manager.dart';

var key1 = ['1'];
var key2 = ['2'];
var key3 = ['3'];
var key4 = ['4'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {

  @override
  void initState() {
    super.initState();
    KeylistenerPlatform.instance.startListening();
    windowManager.setMinimumSize(Size(500, 400));
    windowManager.setAlwaysOnTop(true);
    windowManager.addListener(this);
  }


  @override
  void onWindowClose() {
    KeylistenerPlatform.instance.exit();
  }


  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    final FocusNode secondaryFocusNode3 = FocusNode();
    final FocusNode secondaryFocusNode1 = FocusNode();
    final FocusNode secondaryFocusNode2 = FocusNode();
    final FocusNode secondaryFocusNode4 = FocusNode();
    final FocusNode secondaryFocusNode32 = FocusNode();
    final FocusNode secondaryFocusNode12 = FocusNode();
    final FocusNode secondaryFocusNode22 = FocusNode();
    final FocusNode secondaryFocusNode42 = FocusNode();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4E56A7),
        leading: SizedBox(width: 56),
        // Empty leading widget to leave space for the image
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
          children: [
            SizedBox(
                width: 50,
                height: 40,
                child: SvgPicture.asset('assets/images/Primary_Logo.svg'),)
            // Your image widget
          ],
        ),
        actions: [
          SizedBox(width: 56),
          // Empty widget to balance the space for the image
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawKeyboardListener(
                  focusNode: secondaryFocusNode12,
                  onKey: (event) {
                    setState(() {
                      key1.remove(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.RemoveKey(
                        '1',
                        event.logicalKey.keyLabel
                    );
                    secondaryFocusNode12.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode12.requestFocus();
                    },
                    child: Center(
                      child: Text("Remove Key"),
                    ),
                  ),
                ),
                RawKeyboardListener(
                  focusNode: secondaryFocusNode1,
                  onKey: (event) {
                    setState(() {
                      key1.add(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.addKey(
                      '1',
                      event.logicalKey.keyLabel,
                    );
                    secondaryFocusNode1.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode1.requestFocus();
                    },
                    child: SizedBox(
                      width: screenWidth*0.1,
                      height: screenHeight*0.1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15), // Set background color with opacity
                            borderRadius: BorderRadius.circular(10.0), ),
                        width: max(key1.length*screenWidth * 0.05, screenWidth*0.05),
                        height: screenHeight * 0.09,
                        child: Center(
                          child: Text("${key1}"),
                        ),
                      ),
                    ),
                  ),
                ),
                SoundButton(
                    color: Color(0xFFF25D57),
                    dogy: 'assets/images/butt.jpg',
                    sound: 'sounds/fart1.wav'),
                SoundButton(
                    color: Color(0xFFAF75FF),
                    dogy: 'assets/images/smile.jpg',
                    sound: 'sounds/bark1.wav'),
                RawKeyboardListener(
                  focusNode: secondaryFocusNode2,
                  onKey: (event) {
                    setState(() {
                      key2.add(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.addKey(
                      '2',
                      event.logicalKey.keyLabel,
                    );
                    secondaryFocusNode2.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode2.requestFocus();
                    },
                    child: SizedBox(
                      height: screenHeight*0.1,
                      width: screenWidth*0.1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15), // Set background color with opacity
                          borderRadius: BorderRadius.circular(10.0), ),// Apply rounded corners
                        width: max(key2.length*screenWidth * 0.05, screenWidth*0.05),
                        height: screenHeight * 0.09,
                        child: Center(
                          child: Text("${key2}"),
                        ),
                      ),
                    ),
                  ),
                ),
                RawKeyboardListener(
                  focusNode: secondaryFocusNode22,
                  onKey: (event) {
                    setState(() {
                      key2.remove(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.RemoveKey(
                        '2',
                        event.logicalKey.keyLabel
                    );
                    secondaryFocusNode22.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode22.requestFocus();
                    },
                    child: Center(
                      child: Text("Remove Key"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawKeyboardListener(
                  focusNode: secondaryFocusNode32,
                  onKey: (event) {
                    setState(() {
                      key3.remove(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.RemoveKey(
                        '3',
                        event.logicalKey.keyLabel
                    );
                    secondaryFocusNode32.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode32.requestFocus();
                    },
                    child: Center(
                      child: Text("Remove Key"),
                    ),
                  ),
                ),
                RawKeyboardListener(
                  focusNode: secondaryFocusNode3,
                  onKey: (event) {
                    setState(() {
                      key3.add(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.addKey(
                      '3',
                      event.logicalKey.keyLabel
                    );
                    secondaryFocusNode3.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode3.requestFocus();
                    },
                    child: SizedBox(
                      height: screenHeight*0.1,
                      width: screenWidth*0.1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15), // Set background color with opacity
                          borderRadius: BorderRadius.circular(10.0), ),
                        width: max(key3.length*screenWidth * 0.05, screenWidth*0.05),
                        height: screenHeight * 0.09,
                        child: Center(
                          child: Text("${key3}"),
                        ),
                      ),
                    ),
                  ),
                ),
                SoundButton(
                    color: Color(0xFFAF75FF),
                    dogy: 'assets/images/butt2.jpg',
                    sound: 'sounds/fart2.wav'),
                SoundButton(
                    color: Color(0xFFF25D57),
                    dogy: 'assets/images/smile2.jpg',
                    sound: 'sounds/bark2.wav'),
                RawKeyboardListener(
                  focusNode: secondaryFocusNode4,
                  onKey: (event) {
                    setState(() {
                      key4.add(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.addKey(
                      '4',
                      event.logicalKey.keyLabel
                    );
                    secondaryFocusNode4.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode4.requestFocus();
                    },
                    child: SizedBox(
                      width: screenWidth*0.1,
                      height: screenHeight*0.1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15), // Set background color with opacity
                          borderRadius: BorderRadius.circular(10.0), ),
                        width: max(key4.length*screenWidth * 0.05, screenWidth*0.05),
                        height: screenHeight * 0.09,
                        child: Center(
                          child: Text("${key4}"),
                        ),
                      ),
                    ),
                  ),
                ),
                RawKeyboardListener(
                  focusNode: secondaryFocusNode42,
                  onKey: (event) {
                    setState(() {
                      key4.remove(event.logicalKey.keyLabel);
                    });
                    KeylistenerPlatform.instance.RemoveKey(
                        '4',
                        event.logicalKey.keyLabel
                    );
                    secondaryFocusNode42.unfocus();
                    _focusNode.requestFocus();
                  },
                  child: GestureDetector(
                    onTap: () {
                      secondaryFocusNode42.requestFocus();
                    },
                    child: Center(
                      child: Text("Remove Key"),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: screenHeight * 0.1,
            // ),
            // KeyboardListen(focusNode: _focusNode),
            SizedBox(height: screenHeight*0.12),
            SizedBox(width:screenWidth*0.8,child: CustomSlider()),
          ],
        ),
      ),
    );
  }
}
