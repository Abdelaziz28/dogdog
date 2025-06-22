import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  final double initialValue;
  final Function(double) onVolumeChanged;

  const VolumeSlider({
    super.key,
    this.initialValue = 50.0,
    required this.onVolumeChanged,
  });

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.volume_down,
              color: Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Volume: ${_currentValue.round()}%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.volume_up,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blueAccent,
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            thumbColor: Colors.blueAccent,
            overlayColor: Colors.blueAccent.withOpacity(0.2),
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
          ),
          child: Slider(
            value: _currentValue,
            min: 0,
            max: 100,
            divisions: 100,
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
              });
            },
            onChangeEnd: (newValue) {
              widget.onVolumeChanged(newValue);
            },
          ),
        ),
      ],
    );
  }
}