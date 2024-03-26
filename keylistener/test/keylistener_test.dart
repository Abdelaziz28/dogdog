import 'package:flutter_test/flutter_test.dart';
import 'package:keylistener/keylistener.dart';
import 'package:keylistener/keylistener_platform_interface.dart';
import 'package:keylistener/keylistener_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKeylistenerPlatform
    with MockPlatformInterfaceMixin
    implements KeylistenerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KeylistenerPlatform initialPlatform = KeylistenerPlatform.instance;

  test('$MethodChannelKeylistener is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeylistener>());
  });

  test('getPlatformVersion', () async {
    Keylistener keylistenerPlugin = Keylistener();
    MockKeylistenerPlatform fakePlatform = MockKeylistenerPlatform();
    KeylistenerPlatform.instance = fakePlatform;

    expect(await keylistenerPlugin.getPlatformVersion(), '42');
  });
}
