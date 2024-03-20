import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initSystemTray() async {
  String path = Platform.isWindows
      ? 'assets/images/emoji.ico'
      : 'assets/images/emoji.png';

  final AppWindow appWindow = AppWindow();
  final SystemTray systemTray = SystemTray();

  // We first init the systray menu
  await systemTray.initSystemTray(
    title: "system tray",
    iconPath: path,
  );
  void startListening() {
    // Implement logic to listen for keystrokes
    // Example: KeyboardListener.listen(handleKeyStroke);
  }

  void handleKeyStroke(String keyStroke) {
    // Handle keystrokes and play sounds accordingly
  }

  // create context menu
  final Menu menu = Menu();
  await menu.buildFrom([
    MenuItemLabel(
        label: 'Show',
        onClicked: (menuItem) {
          windowManager.setSize(Size(800, 600));
          windowManager.center();
          windowManager.focus();
          windowManager.setOpacity(1);
        }),
    MenuItemLabel(label: 'Play', onClicked: (menuItem) => appWindow.show()),
    MenuItemLabel(
        label: 'Pause',
        onClicked: (menuItem) {
          appWindow.hide();
        }),
    MenuItemLabel(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
  ]);

  // set context menu
  await systemTray.setContextMenu(menu);

  // handle system tray event
  systemTray.registerSystemTrayEventHandler((eventName) {
    debugPrint("eventName: $eventName");
    if (eventName == kSystemTrayEventClick) {
      Platform.isWindows ? appWindow.show() : systemTray.popUpContextMenu();
    } else if (eventName == kSystemTrayEventRightClick) {
      Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
    }
  });
}


