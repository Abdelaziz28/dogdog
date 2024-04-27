import 'package:flutter/material.dart';
import 'package:keylistener/keylistener_platform_interface.dart';

class CustomSlider extends StatefulWidget {

  const CustomSlider({Key? key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}
class _CustomSliderState extends State<CustomSlider> {
  double _value = 50;

  @override
  Widget build(BuildContext context) {
    KeylistenerPlatform.instance.setVol(_value.round());
    return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: Colors.blueAccent,
            overlayColor: Colors.blue.withAlpha(32),
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
          ),
      child: Slider(
        value: _value,
        min: 1,
        max: 100,
        divisions: 99,
        onChanged: (newValue) {
          setState(() {
            _value = newValue;
            KeylistenerPlatform.instance.setVol(newValue.round());
          });
        },

      ),
    );
  }
}