#include "keylistener_plugin.h"
#include <flutter/method_channel.h>
#include <flutter/encodable_value.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>
#include <iostream>
#include <memory>
#include <sstream>
#include <VersionHelpers.h>
#include <mmdeviceapi.h>
#include <endpointvolume.h>
#include <audiopolicy.h>
#include <vector>
#include <map>
#include <string>
#include <thread>
#include <mutex>

#pragma comment(lib, "Winmm.lib")

using namespace flutter;

namespace keylistener {

    // Thread-safe key bindings storage
    class KeyBindingManager {
    private:
        std::mutex mutex_;
        std::map<char, std::map<char, bool>> soundBindings_;
        
    public:
        KeyBindingManager() {
            // Initialize default bindings
            soundBindings_['1']['1'] = true;
            soundBindings_['2']['2'] = true;
            soundBindings_['3']['3'] = true;
            soundBindings_['4']['4'] = true;
        }
        
        void addKey(char soundId, char key) {
            std::lock_guard<std::mutex> lock(mutex_);
            soundBindings_[soundId][key] = true;
        }
        
        void removeKey(char soundId, char key) {
            std::lock_guard<std::mutex> lock(mutex_);
            soundBindings_[soundId][key] = false;
        }
        
        bool isKeyBound(char soundId, char key) {
            std::lock_guard<std::mutex> lock(mutex_);
            return soundBindings_[soundId][key];
        }
    };

    // Global instances
    static KeyBindingManager* g_keyManager = nullptr;
    static HHOOK g_keyboardHook = nullptr;
    static std::thread* g_messageThread = nullptr;
    static bool g_shouldExit = false;

    // Sound file paths
    const std::string SOUND_PATHS[] = {
        "assets\\sounds\\fart1.wav",
        "assets\\sounds\\bark1.wav", 
        "assets\\sounds\\fart2.wav",
        "assets\\sounds\\bark2.wav"
    };

    void playSound(int soundIndex) {
        if (soundIndex >= 0 && soundIndex < 4) {
            PlaySoundA(SOUND_PATHS[soundIndex].c_str(), NULL, SND_ASYNC | SND_FILENAME);
        }
    }

    LRESULT CALLBACK KeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
        if (nCode == HC_ACTION && wParam == WM_KEYDOWN && g_keyManager) {
            PKBDLLHOOKSTRUCT p = (PKBDLLHOOKSTRUCT)lParam;
            char key = static_cast<char>(p->vkCode);
            
            // Check each sound binding
            if (g_keyManager->isKeyBound('1', key)) {
                playSound(0);
            }
            if (g_keyManager->isKeyBound('2', key)) {
                playSound(1);
            }
            if (g_keyManager->isKeyBound('3', key)) {
                playSound(2);
            }
            if (g_keyManager->isKeyBound('4', key)) {
                playSound(3);
            }
        }
        return CallNextHookEx(g_keyboardHook, nCode, wParam, lParam);
    }

    void messageLoop() {
        MSG msg;
        while (!g_shouldExit && GetMessage(&msg, NULL, 0, 0)) {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    // Static methods
    void KeylistenerPlugin::RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar) {
        auto channel = std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "keylistener",
            &flutter::StandardMethodCodec::GetInstance());

        auto plugin = std::make_unique<KeylistenerPlugin>();

        channel->SetMethodCallHandler(
            [plugin_pointer = plugin.get()](const auto& call, auto result) {
                plugin_pointer->HandleMethodCall(call, std::move(result));
            });

        registrar->AddPlugin(std::move(plugin));
    }

    KeylistenerPlugin::KeylistenerPlugin() {
        if (!g_keyManager) {
            g_keyManager = new KeyBindingManager();
        }
    }

    KeylistenerPlugin::~KeylistenerPlugin() {
        cleanup();
    }

    void KeylistenerPlugin::cleanup() {
        g_shouldExit = true;
        
        if (g_keyboardHook) {
            UnhookWindowsHookEx(g_keyboardHook);
            g_keyboardHook = nullptr;
        }
        
        if (g_messageThread && g_messageThread->joinable()) {
            g_messageThread->join();
            delete g_messageThread;
            g_messageThread = nullptr;
        }
        
        if (g_keyManager) {
            delete g_keyManager;
            g_keyManager = nullptr;
        }
    }

    void KeylistenerPlugin::HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue>& method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
        
        const std::string& method = method_call.method_name();

        if (method == "getPlatformVersion") {
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
        }
        else if (method == "startListening") {
            if (!g_keyboardHook) {
                g_keyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL, KeyboardProc, NULL, 0);
                if (g_keyboardHook) {
                    g_shouldExit = false;
                    g_messageThread = new std::thread(messageLoop);
                    result->Success(flutter::EncodableValue("Listening started"));
                } else {
                    result->Error("HOOK_ERROR", "Failed to set keyboard hook");
                }
            } else {
                result->Success(flutter::EncodableValue("Already listening"));
            }
        }
        else if (method == "Exit") {
            cleanup();
            result->Success(flutter::EncodableValue("Exited"));
            std::exit(0);
        }
        else if (method == "SetVolume") {
            const auto* arguments = std::get_if<flutter::EncodableList>(method_call.arguments());
            if (arguments && !arguments->empty()) {
                int volume = std::get<int>((*arguments)[0]);
                int newVolume = (volume * 65535) / 100;
                MMRESULT mmResult = waveOutSetVolume(0, MAKELONG(newVolume, newVolume));
                if (mmResult == MMSYSERR_NOERROR) {
                    result->Success(flutter::EncodableValue("Volume set"));
                } else {
                    result->Error("VOLUME_ERROR", "Failed to set volume");
                }
            } else {
                result->Error("INVALID_ARGS", "Volume parameter required");
            }
        }
        else if (method == "AddKey") {
            const auto* arguments = std::get_if<flutter::EncodableList>(method_call.arguments());
            if (arguments && arguments->size() >= 2) {
                std::string soundId = std::get<std::string>((*arguments)[0]);
                std::string keyStr = std::get<std::string>((*arguments)[1]);
                
                if (!soundId.empty() && !keyStr.empty()) {
                    char soundChar = soundId[0];
                    char keyChar = keyStr[0];
                    g_keyManager->addKey(soundChar, keyChar);
                    result->Success(flutter::EncodableValue("Key added"));
                } else {
                    result->Error("INVALID_ARGS", "Sound ID and key cannot be empty");
                }
            } else {
                result->Error("INVALID_ARGS", "Sound ID and key parameters required");
            }
        }
        else if (method == "RemoveKey") {
            const auto* arguments = std::get_if<flutter::EncodableList>(method_call.arguments());
            if (arguments && arguments->size() >= 2) {
                std::string soundId = std::get<std::string>((*arguments)[0]);
                std::string keyStr = std::get<std::string>((*arguments)[1]);
                
                if (!soundId.empty() && !keyStr.empty()) {
                    char soundChar = soundId[0];
                    char keyChar = keyStr[0];
                    g_keyManager->removeKey(soundChar, keyChar);
                    result->Success(flutter::EncodableValue("Key removed"));
                } else {
                    result->Error("INVALID_ARGS", "Sound ID and key cannot be empty");
                }
            } else {
                result->Error("INVALID_ARGS", "Sound ID and key parameters required");
            }
        }
        else {
            result->NotImplemented();
        }
    }

}  // namespace keylistener