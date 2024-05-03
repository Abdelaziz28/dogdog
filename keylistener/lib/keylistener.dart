
import 'keylistener_platform_interface.dart';

class Keylistener {
  Future<String?> getPlatformVersion() {
    return KeylistenerPlatform.instance.getPlatformVersion();
  }
  Future startListening() {
    return KeylistenerPlatform.instance.getPlatformVersion();
  }
  Future exit() {
    return KeylistenerPlatform.instance.exit();
  }
  Future<void> reloadKeys(String param1, String param2, String param3, String param4) async {
    return KeylistenerPlatform.instance.reloadKeys(param1, param2, param3, param4);
  }
  Future<void> setVol(int volume) async {
    return KeylistenerPlatform.instance.setVol(volume);
  }
  Future<void> addKey(String which, String what) async {
    return KeylistenerPlatform.instance.addKey(which,what);
  }Future<void> RemoveKey(String which, String what) async {

    return KeylistenerPlatform.instance.RemoveKey(which,what);
  }
}
