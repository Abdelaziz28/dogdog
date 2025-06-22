import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../controllers/soundboard_controller.dart';
import '../core/app_config.dart';
import 'widgets/key_binding_widget.dart';
import 'widgets/sound_button.dart';
import 'widgets/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  late SoundboardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SoundboardController();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _controller.initialize();
    windowManager.addListener(this);
  }

  @override
  void onWindowClose() {
    _controller.dispose();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppConfig.primaryColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 32,
            child: SvgPicture.asset(
              'assets/images/Primary_Logo.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            AppConfig.appName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Expanded(
            child: _buildSoundGrid(),
          ),
          const SizedBox(height: 32),
          _buildVolumeControl(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSoundGrid() {
    return Consumer<SoundboardController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            // First row
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSoundSection(AppConfig.soundButtons[0], controller),
                  _buildSoundSection(AppConfig.soundButtons[1], controller),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Second row
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSoundSection(AppConfig.soundButtons[2], controller),
                  _buildSoundSection(AppConfig.soundButtons[3], controller),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSoundSection(
    SoundButtonConfig config,
    SoundboardController controller,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Key binding widget
        KeyBindingWidget(
          soundId: config.id,
          keys: controller.getKeysForSound(config.id),
          onAddKey: (key) => controller.addKey(config.id, key),
          onRemoveKey: (key) => controller.removeKey(config.id, key),
        ),
        const SizedBox(height: 16),
        // Sound button
        SoundButton(
          color: config.color,
          imagePath: config.imagePath,
          soundPath: config.soundPath,
        ),
      ],
    );
  }

  Widget _buildVolumeControl() {
    return Consumer<SoundboardController>(
      builder: (context, controller, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: VolumeSlider(
            initialValue: controller.volume,
            onVolumeChanged: controller.setVolume,
          ),
        );
      },
    );
  }
}
