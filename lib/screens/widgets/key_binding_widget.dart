import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyBindingWidget extends StatefulWidget {
  final String soundId;
  final List<String> keys;
  final Function(String key) onAddKey;
  final Function(String key) onRemoveKey;

  const KeyBindingWidget({
    super.key,
    required this.soundId,
    required this.keys,
    required this.onAddKey,
    required this.onRemoveKey,
  });

  @override
  State<KeyBindingWidget> createState() => _KeyBindingWidgetState();
}

class _KeyBindingWidgetState extends State<KeyBindingWidget> {
  final FocusNode _addFocusNode = FocusNode();
  final FocusNode _removeFocusNode = FocusNode();
  bool _isAddingKey = false;
  bool _isRemovingKey = false;

  @override
  void dispose() {
    _addFocusNode.dispose();
    _removeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Key display container
        Container(
          width: screenWidth * 0.12,
          height: screenHeight * 0.08,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isAddingKey || _isRemovingKey 
                  ? Colors.blue 
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              widget.keys.join(', '),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Add key button
            _buildKeyButton(
              label: "Add",
              focusNode: _addFocusNode,
              isActive: _isAddingKey,
              onTap: _startAddingKey,
              onKey: _handleAddKey,
              color: Colors.green,
            ),
            
            // Remove key button
            _buildKeyButton(
              label: "Remove",
              focusNode: _removeFocusNode,
              isActive: _isRemovingKey,
              onTap: _startRemovingKey,
              onKey: _handleRemoveKey,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyButton({
    required String label,
    required FocusNode focusNode,
    required bool isActive,
    required VoidCallback onTap,
    required Function(KeyEvent) onKey,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Focus(
          focusNode: focusNode,
          onKeyEvent: onKey,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _startAddingKey() {
    setState(() {
      _isAddingKey = true;
      _isRemovingKey = false;
    });
    _addFocusNode.requestFocus();
  }

  void _startRemovingKey() {
    setState(() {
      _isRemovingKey = true;
      _isAddingKey = false;
    });
    _removeFocusNode.requestFocus();
  }

  KeyEventResult _handleAddKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      final keyLabel = event.logicalKey.keyLabel;
      if (keyLabel.isNotEmpty) {
        widget.onAddKey(keyLabel);
        setState(() {
          _isAddingKey = false;
        });
        _addFocusNode.unfocus();
      }
    }
    return KeyEventResult.handled;
  }

  KeyEventResult _handleRemoveKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      final keyLabel = event.logicalKey.keyLabel;
      if (keyLabel.isNotEmpty) {
        widget.onRemoveKey(keyLabel);
        setState(() {
          _isRemovingKey = false;
        });
        _removeFocusNode.unfocus();
      }
    }
    return KeyEventResult.handled;
  }
}
