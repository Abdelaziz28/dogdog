import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:registration_screens_task1/screens/widgets/keybinds.dart';
import 'package:registration_screens_task1/screens/widgets/sound_button.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import '../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  final AppWindow appWindow = AppWindow();
  @override
  void initState() {
    super.initState();
    windowManager.setMinimumSize(Size(500,400));
    windowManager.setAlwaysOnTop(true);
    windowManager.addListener(this);
  }
  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }
  // @override
  // Future<void> onWindowClose() async {
  //   await windowManager.hide();
  //   await windowManager.focus();
  // }

  @override
  Future<void> onWindowMinimize() async {
    windowManager.setMinimumSize(Size(50,50));
    windowManager.setSize(Size(60,60));
    windowManager.setOpacity(0);
    // appWindow.show();
    windowManager.focus();
  }

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
                          model.changeKey1(event.logicalKey);
                          secondaryFocusNode1.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: (){secondaryFocusNode1.requestFocus();},
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth*0.05,
                              height: screenHeight*0.09,
                              child: Center(
                                child: Text(
                                  "${model.key1.keyLabel}"
                                ),
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
                          model.changeKey2(event.logicalKey);
                          secondaryFocusNode2.unfocus();
                          _focusNode.requestFocus();

                        },
                        child: GestureDetector(
                          onTap: (){
                            secondaryFocusNode2.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth*0.05,
                              height: screenHeight*0.09,
                              child: Center(
                                child: Text(
                                    "${model.key2.keyLabel}"
                                ),
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
                          model.changeKey3(event.logicalKey);
                          secondaryFocusNode3.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: (){
                            secondaryFocusNode3.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth*0.05,
                              height: screenHeight*0.09,
                              child: Center(
                                child: Text(
                                    "${model.key3.keyLabel}"
                                ),
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
                          model.changeKey4(event.logicalKey);
                          secondaryFocusNode4.unfocus();
                          _focusNode.requestFocus();
                        },
                        child: GestureDetector(
                          onTap: (){
                            secondaryFocusNode4.requestFocus();
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.15),
                              width: screenWidth*0.05,
                              height: screenHeight*0.09,
                              child: Center(
                                child: Text(
                                    "${model.key4.keyLabel}"
                                ),
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
                  KeyboardListen(focusNode: _focusNode)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
