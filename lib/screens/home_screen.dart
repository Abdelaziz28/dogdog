import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:keylistener/keylistener_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:registration_screens_task1/screens/widgets/keybinds.dart';
import 'package:registration_screens_task1/screens/widgets/slider.dart';
import 'package:registration_screens_task1/screens/widgets/sound_button.dart';
// import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import '../../main.dart';

var key1 = '1', key2 = '2', key3 = '3', key4 = '4';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {

  @override
  void initState() {
    super.initState();
    windowManager.setMinimumSize(Size(500, 400));
    windowManager.setAlwaysOnTop(true);
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    KeylistenerPlatform.instance.exit();
    super.dispose();
  }
  //
  @override
  Future<void> onWindowClose() async {
    KeylistenerPlatform.instance.exit();
    this.dispose();
  }
  //
  // @override
  // Future<void> onWindowMinimize() async {
  //   windowManager.setMinimumSize(Size(50, 50));
  //   windowManager.setSize(Size(60, 60));
  //   windowManager.setOpacity(0);
  //   // appWindow.show();
  //   windowManager.focus();
  // }

  // @override
  // Future<void> onWindowBlur() async {
  //   windowManager.setMinimumSize(Size(50,50));
  //   windowManager.setSize(Size(60,60));
  //   windowManager.setOpacity(0);
  //   appWindow.show();
  //
  //   // windowManager.focus();
  // }

  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    final FocusNode secondaryFocusNode3 = FocusNode();
    final FocusNode secondaryFocusNode1 = FocusNode();
    final FocusNode secondaryFocusNode2 = FocusNode();
    final FocusNode secondaryFocusNode4 = FocusNode();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/chattyCaps.png'),
        backgroundColor: Color(0xFF4E56A7),
      ),
      body: ChangeNotifierProvider(
        create: (context) => KeybindSetter(),
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Consumer<KeybindSetter>(
            builder: (context, model, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RawKeyboardListener(
                        focusNode: secondaryFocusNode1,
                        onKey: (event) {
                          key1 = event.logicalKey.keyLabel;
                          setState(() {
                            key1 = event.logicalKey.keyLabel;
                          });
                          KeylistenerPlatform.instance.reloadKeys(
                            key1,
                            key2,
                            key3,
                            key4,
                          );
                          secondaryFocusNode1.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: () {
                            secondaryFocusNode1.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth * 0.05,
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
                          sound: 'sounds/fart2.wav'),
                      SoundButton(
                          color: Color(0xFFAF75FF),
                          dogy: 'assets/images/smile.jpg',
                          sound: 'sounds/bark1.wav'),
                      RawKeyboardListener(
                        focusNode: secondaryFocusNode2,
                        onKey: (event) {
                          key2 = event.logicalKey.keyLabel;
                          setState(() {
                            key2 = event.logicalKey.keyLabel;
                          });
                          KeylistenerPlatform.instance.reloadKeys(
                            key1,
                            key2,
                            key3,
                            key4,
                          );
                          secondaryFocusNode2.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: () {
                            secondaryFocusNode2.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth * 0.05,
                              height: screenHeight * 0.09,
                              child: Center(
                                child: Text("${key2}"),
                              ),
                            ),
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
                        focusNode: secondaryFocusNode3,
                        onKey: (event) {
                          setState(() {
                            key3 = event.logicalKey.keyLabel;
                          });
                          KeylistenerPlatform.instance.reloadKeys(
                            key1,
                            key2,
                            key3,
                            key4,
                          );
                          secondaryFocusNode3.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: () {
                            secondaryFocusNode3.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth * 0.05,
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
                          sound: 'sounds/fart1.wav'),
                      SoundButton(
                          color: Color(0xFFF25D57),
                          dogy: 'assets/images/smile2.jpg',
                          sound: 'sounds/bark2.wav'),
                      RawKeyboardListener(
                        focusNode: secondaryFocusNode4,
                        onKey: (event) {
                          setState(() {
                            key4 = event.logicalKey.keyLabel;
                          });
                          KeylistenerPlatform.instance.reloadKeys(
                            key1,
                            key2,
                            key3,
                            key4,
                          );
                          secondaryFocusNode4.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: () {
                            secondaryFocusNode4.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth * 0.05,
                              height: screenHeight * 0.09,
                              child: Center(
                                child: Text("${key4}"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.1,
                  // ),
                  KeyboardListen(focusNode: _focusNode),
                  SizedBox(height: screenHeight*0.12),
                  SizedBox(width:screenWidth*0.8,child: CustomSlider()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
