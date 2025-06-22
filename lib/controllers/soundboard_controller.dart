import 'package:flutter/foundation.dart';
import 'package:keylistener/keylistener_platform_interface.dart';
import '../models/soundboard_models.dart';

class SoundboardController extends ChangeNotifier {
  SoundboardState _state = SoundboardState.defaultState;
  
  SoundboardState get state => _state;
  
  Map<String, KeyBinding> get keyBindings => _state.keyBindings;
  double get volume => _state.volume;

  // Initialize the soundboard
  Future<void> initialize() async {
    try {
      await KeylistenerPlatform.instance.startListening();
      await _updateNativeKeyBindings();
      await _updateNativeVolume();
    } catch (e) {
      debugPrint('Failed to initialize soundboard: $e');
    }
  }

  // Update volume
  Future<void> setVolume(double newVolume) async {
    _state = _state.copyWith(volume: newVolume);
    await _updateNativeVolume();
    notifyListeners();
  }

  // Add key to sound binding
  Future<void> addKey(String soundId, String key) async {
    final currentBinding = _state.keyBindings[soundId];
    if (currentBinding != null) {
      currentBinding.addKey(key);
      await KeylistenerPlatform.instance.addKey(soundId, key);
      notifyListeners();
    }
  }

  // Remove key from sound binding
  Future<void> removeKey(String soundId, String key) async {
    final currentBinding = _state.keyBindings[soundId];
    if (currentBinding != null) {
      currentBinding.removeKey(key);
      await KeylistenerPlatform.instance.RemoveKey(soundId, key);
      notifyListeners();
    }
  }

  // Get keys for a specific sound
  List<String> getKeysForSound(String soundId) {
    return _state.keyBindings[soundId]?.keys ?? [];
  }

  // Cleanup when app closes
  Future<void> dispose() async {
    try {
      await KeylistenerPlatform.instance.exit();
    } catch (e) {
      debugPrint('Failed to cleanup soundboard: $e');
    }
    super.dispose();
  }

  // Private helper methods
  Future<void> _updateNativeKeyBindings() async {
    try {
      // Update all key bindings in the native plugin
      for (final binding in _state.keyBindings.values) {
        for (final key in binding.keys) {
          await KeylistenerPlatform.instance.addKey(binding.soundId, key);
        }
      }
    } catch (e) {
      debugPrint('Failed to update native key bindings: $e');
    }
  }

  Future<void> _updateNativeVolume() async {
    try {
      await KeylistenerPlatform.instance.setVol(_state.volume.round());
    } catch (e) {
      debugPrint('Failed to update native volume: $e');
    }
  }
}
