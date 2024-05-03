import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keylistener_method_channel.dart';

abstract class KeylistenerPlatform extends PlatformInterface {
  /// Constructs a KeylistenerPlatform.
  KeylistenerPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeylistenerPlatform _instance = MethodChannelKeylistener();

  /// The default instance of [KeylistenerPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeylistener].
  static KeylistenerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KeylistenerPlatform] when
  /// they register themselves.
  static set instance(KeylistenerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future startListening() async{
    await _instance.startListening();
  }
  Future exit() async{
    await _instance.exit();
  }
  Future reload1() async{
    await _instance.reload1();
  }Future reload2() async{
    await _instance.reload2();
  }Future reload3() async{
    await _instance.reload3();
  }Future reload4() async{
    await _instance.reload4();
  }
  Future<void> reloadKeys(String param1, String param2, String param3, String param4) async {
   await _instance.reloadKeys(param1, param2, param3, param4);
  }
  Future<void> setVol(int volume) async {
   await _instance.setVol(volume);
  }
Future<void> addKey(String which, String what) async {
   await _instance.addKey(which,what);
  }
  Future<void> RemoveKey(String which, String what) async {
   await _instance.RemoveKey(which,what);
  }

}
