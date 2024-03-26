import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keylistener_platform_interface.dart';

/// An implementation of [KeylistenerPlatform] that uses method channels.
class MethodChannelKeylistener extends KeylistenerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('keylistener');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  Future startListening() async {
    await methodChannel.invokeMethod<String>('startListening');
  }
  Future exit() async {
    await methodChannel.invokeMethod<String>('Exit');
  }Future reload1() async {
    await methodChannel.invokeMethod<String>('reload1');
  }Future reload2() async {
    await methodChannel.invokeMethod<String>('reload2');
  }Future reload3() async {
    await methodChannel.invokeMethod<String>('reload3');
  }Future reload4() async {
    await methodChannel.invokeMethod<String>('reload4');
  }
  Future<void> reloadKeys(String param1, String param2, String param3, String param4) async {
    try {
      await methodChannel.invokeMethod('reloadKeys', {
        'param1': param1,
        'param2': param2,
        'param3': param3,
        'param4': param4,
      });
    } catch (e) {
      print("Error: $e");
    }
}}
