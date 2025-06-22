# 🐶 Dog Soundboard

A delightfully fun and interactive Flutter desktop soundboard application that lets you play dog sounds with customizable keyboard shortcuts. Perfect for pranks, entertainment, or just adding some joy to your day!

## ✨ Features

- **🎵 Four Unique Sound Effects**: Mix of barks and... other amusing dog sounds
- **⌨️ Customizable Keybindings**: Assign any keyboard key to trigger your favorite sounds
- **🔊 Volume Control**: Adjust the playback volume with a smooth slider
- **🖱️ Click to Play**: Mouse-friendly interface with beautiful animated buttons
- **� Always on Top**: Stay accessible while using other applications
- **🎨 Modern UI**: Clean, intuitive design with smooth animations
- **⚡ Global Hotkeys**: Trigger sounds even when the app isn't in focus

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.1.1 or higher)
- Windows 10/11 (currently Windows-only due to native plugin)
- Visual Studio with C++ development tools (for building the native plugin)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd dogdog
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d windows
   ```

## 🎮 How to Use

### Playing Sounds
- **Click**: Simply click any of the four colorful sound buttons to play a sound
- **Keyboard**: Use your assigned keys (default: 1, 2, 3, 4) to trigger sounds from anywhere

### Customizing Keybindings
1. **Add a Key**: Click the green "Add" button below any sound button
2. **Press the Key**: Type the key you want to assign to that sound
3. **Remove a Key**: Click the red "Remove" button and press the key to unassign

### Volume Control
- Use the volume slider at the bottom to adjust playback volume
- Changes apply instantly to all sounds

## 🏗️ Project Structure

```
lib/
├── core/
│   └── app_config.dart          # Application configuration and theme
├── controllers/
│   └── soundboard_controller.dart # State management for the soundboard
├── models/
│   └── soundboard_models.dart    # Data models for key bindings
├── screens/
│   ├── home_screen.dart         # Main application screen
│   └── widgets/
│       ├── key_binding_widget.dart # Key assignment interface
│       ├── slider.dart          # Volume control slider
│       └── sound_button.dart    # Animated sound buttons
└── main.dart                    # Application entry point

keylistener/                     # Custom native plugin
├── lib/                         # Dart plugin interface
└── windows/                     # Windows-specific C++ implementation
```

## � Technical Details

### Architecture
- **State Management**: Provider pattern for reactive UI updates
- **Native Integration**: Custom Windows plugin using low-level keyboard hooks
- **Audio Playback**: Flutter's audioplayers package for cross-platform sound
- **UI Framework**: Material Design with custom theming

### Native Plugin Features
- **Global Keyboard Hook**: Captures key presses system-wide
- **Thread-Safe Design**: Proper synchronization for concurrent access
- **Memory Management**: Automatic cleanup and resource management
- **Error Handling**: Robust error reporting and recovery

### Performance Optimizations
- **Lazy Loading**: Sounds loaded on-demand
- **Efficient Animations**: Hardware-accelerated transformations
- **Memory Conscious**: Proper disposal of resources

## 🎨 Customization

### Adding New Sounds
1. Place your `.wav` files in `assets/sounds/`
2. Add entries to `AppConfig.soundButtons` in `lib/core/app_config.dart`
3. Update the native plugin to handle additional sound IDs

### Changing Themes
- Modify colors in `AppConfig` class
- Update the Material theme configuration
- Customize widget styling as needed

### Sound Button Images
- Replace images in `assets/images/`
- Update the image paths in `AppConfig.soundButtons`
- Images are automatically clipped to rounded rectangles

## � Supported Platforms

- ✅ **Windows 10/11**: Full functionality with global hotkeys
- ⏳ **macOS**: Coming soon (requires native plugin adaptation)
- ⏳ **Linux**: Planned for future release

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes** and test thoroughly
4. **Commit your changes** (`git commit -m 'Add amazing feature'`)
5. **Push to the branch** (`git push origin feature/amazing-feature`)
6. **Open a Pull Request**

### Development Guidelines
- Follow Dart/Flutter best practices
- Write descriptive commit messages
- Test on multiple Windows versions
- Update documentation for new features

## � Troubleshooting

### Common Issues

**App won't start or crashes immediately**
- Ensure you have Visual Studio C++ tools installed
- Try running `flutter clean && flutter pub get`
- Check Windows Defender isn't blocking the app

**Sounds not playing**
- Verify audio files exist in `assets/sounds/`
- Check system volume and app volume settings
- Try different audio file formats

**Global hotkeys not working**
- Run the app as administrator if needed
- Check if other apps are intercepting the same keys
- Verify the native plugin compiled correctly

**Performance issues**
- Close other resource-intensive applications
- Check available system memory
- Consider reducing audio file sizes

## � License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## � Acknowledgments

- Flutter team for the amazing framework
- AudioPlayers plugin contributors
- The Flutter community for endless inspiration
- Dog owners everywhere for the... sound inspiration �

## � Support

Having issues or questions?
- Check the [Issues](../../issues) page for known problems
- Create a new issue with detailed reproduction steps
- Include your Flutter version and Windows version

---

**Made with ❤️ and Flutter**

*Happy soundboarding! 🎉*
