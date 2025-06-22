import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundButton extends StatefulWidget {
  const SoundButton({
    super.key,
    required this.color,
    required this.imagePath,
    required this.soundPath,
    this.onPressed,
  });

  final Color color;
  final String imagePath;
  final String soundPath;
  final VoidCallback? onPressed;

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound() async {
    if (_isPlaying) return;

    setState(() => _isPlaying = true);
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    try {
      await _audioPlayer.play(AssetSource(widget.soundPath));
      widget.onPressed?.call();
    } catch (e) {
      debugPrint('Error playing sound: $e');
    } finally {
      // Reset playing state after a short delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() => _isPlaying = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: InkWell(
            onTap: _playSound,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: screenHeight * 0.22,
              width: screenWidth * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: widget.color.withOpacity(0.3),
                          child: const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
                    ),
                    if (_isPlaying)
                      Container(
                        color: Colors.white.withOpacity(0.3),
                        child: const Center(
                          child: Icon(
                            Icons.volume_up,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}