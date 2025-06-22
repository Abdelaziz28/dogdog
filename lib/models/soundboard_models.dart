class KeyBinding {
  final String soundId;
  final List<String> keys;

  KeyBinding({
    required this.soundId,
    required this.keys,
  });

  KeyBinding copyWith({
    String? soundId,
    List<String>? keys,
  }) {
    return KeyBinding(
      soundId: soundId ?? this.soundId,
      keys: keys ?? this.keys,
    );
  }

  void addKey(String key) {
    if (!keys.contains(key)) {
      keys.add(key);
    }
  }

  void removeKey(String key) {
    keys.remove(key);
  }

  @override
  String toString() => 'KeyBinding(soundId: $soundId, keys: $keys)';
}

class SoundboardState {
  final Map<String, KeyBinding> keyBindings;
  final double volume;

  SoundboardState({
    required this.keyBindings,
    this.volume = 50.0,
  });

  SoundboardState copyWith({
    Map<String, KeyBinding>? keyBindings,
    double? volume,
  }) {
    return SoundboardState(
      keyBindings: keyBindings ?? this.keyBindings,
      volume: volume ?? this.volume,
    );
  }

  static SoundboardState get defaultState => SoundboardState(
    keyBindings: {
      '1': KeyBinding(soundId: '1', keys: ['1']),
      '2': KeyBinding(soundId: '2', keys: ['2']),
      '3': KeyBinding(soundId: '3', keys: ['3']),
      '4': KeyBinding(soundId: '4', keys: ['4']),
    },
    volume: 50.0,
  );
}
