//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;

#include "keylistener_plugin.h"
#include "flutter/flutter_engine.h"
#include "flutter/method_channel.h"
#include "flutter/plugin_registrar.h"
#include "flutter/standard_method_codec.h"
#include <flutter/method_channel.h>
#include <flutter/encodable_value.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>
#include <iostream>
#include <memory>
#include <sstream>// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>
#pragma comment(lib, "Winmm.lib")


using namespace flutter;
// This must be included before many other Windows headers.

char key1 = '1', key2 = '2',key3 = '3', key4 = '4';
void playSound(const char* soundPath) {
    PlaySoundA(soundPath, NULL, SND_ASYNC | SND_FILENAME);
}
LRESULT CALLBACK KeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode == HC_ACTION) {
        PKBDLLHOOKSTRUCT p = (PKBDLLHOOKSTRUCT)lParam;
        if (wParam == WM_KEYDOWN) {
            if(static_cast<unsigned char>(p->vkCode) == static_cast<unsigned char>(key1)){
                playSound("assets\\bark1.wav");

            }
            if(static_cast<unsigned char>(p->vkCode) == static_cast<unsigned char>(key2)){
                playSound("assets\\bark2.wav");

            }
            if(static_cast<unsigned char>(p->vkCode) == static_cast<unsigned char>(key3)){
                playSound("assets\\fart1.wav");

            }
            if(static_cast<unsigned char>(p->vkCode) == static_cast<unsigned char>(key4)){
                playSound("assets\\fart2.wav");

            }
        }
    }
    return CallNextHookEx(NULL, nCode, wParam, lParam);
}
namespace keylistener {

// static
void KeylistenerPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "keylistener",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<KeylistenerPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

KeylistenerPlugin::KeylistenerPlugin() {}

KeylistenerPlugin::~KeylistenerPlugin() {}

void KeylistenerPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  } else if(method_call.method_name().compare("startListening") == 0){
      HHOOK hook = SetWindowsHookEx(WH_KEYBOARD_LL, KeyboardProc, NULL, 0);
      if (hook == NULL) {
//          cout << "Failed to install hook" << endl;
          return;
      }
      // Message loop to keep the application running
      MSG msg;
      while (GetMessage(&msg, NULL, 0, 0)) {
          TranslateMessage(&msg);
          DispatchMessage(&msg);
      }
      // Unhook and exit
      UnhookWindowsHookEx(hook);
  }else if(method_call.method_name().compare("reloadKeys") == 0){
      const auto* arguments = std::get_if<flutter::EncodableList>(method_call.arguments());
      if (arguments == nullptr || arguments->size() != 4) {
          result->Error("Invalid arguments", "Expected 4 string arguments");
          return;
      }
      std::string param1 = std::get<std::string>((*arguments)[0]);
      std::string param2 = std::get<std::string>((*arguments)[1]);
      std::string param3 = std::get<std::string>((*arguments)[2]);
      std::string param4 = std::get<std::string>((*arguments)[3]);
      char key11 = param1[0];
      char key22 = param2[0];
      char key33 = param3[0];
      char key44 = param4[0];
      key1 = key11;
      key2 = key22;
      key3 = key33;
      key4 = key44;
  }else if((method_call.method_name().compare("Exit") == 0)){
      exit(EXIT_SUCCESS);
  }else {
    result->NotImplemented();
  }
}

}  // namespace keylistener
