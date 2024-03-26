#include "include/keylistener/keylistener_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "keylistener_plugin.h"

void KeylistenerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  keylistener::KeylistenerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
