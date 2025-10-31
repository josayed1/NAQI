# Naqi - نقي App

**Smart Content Filtering Application for Privacy Protection**

<div align="center">
  <img src="assets/models/app_logo.png" alt="Naqi Logo" width="120"/>
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.35.4-02569B?logo=flutter)](https://flutter.dev)
  [![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](https://www.android.com)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

## 🌿 Overview

Naqi (نقي) is an intelligent content filtering application that uses machine learning to detect and blur inappropriate visual content in real-time. All processing happens locally on your device to ensure complete privacy.

### ✨ Key Features

- 🔒 **100% Privacy**: All processing occurs offline on your device
- 🎯 **Smart Detection**: TensorFlow Lite powered NSFW content detection
- 🎨 **Real-time Filtering**: Automatic blur overlay for sensitive content
- 🌍 **Bilingual**: Full support for Arabic (RTL) and English
- 🔐 **Parental Control**: PIN-protected settings for family safety
- 🔕 **Quiet Mode**: Silent operation without notifications
- ⚙️ **Adjustable Sensitivity**: Low, Medium, and High filtering levels
- 🚀 **Auto-start**: Automatic protection on device boot

## 📱 Screenshots

[Coming Soon]

## 🏗️ Architecture

### Technology Stack

- **Framework**: Flutter 3.35.4
- **ML Framework**: TensorFlow Lite 0.10.4
- **State Management**: Provider 6.1.5+1
- **Local Storage**: SharedPreferences 2.5.3
- **Background Service**: flutter_foreground_task 8.17.0
- **Permissions**: permission_handler 11.4.0
- **Image Processing**: image 4.5.4

### System Components

1. **Flutter App Layer**
   - User Interface (Material Design 3)
   - State Management (Provider)
   - Localization (Arabic/English)

2. **ML Detection Layer**
   - TensorFlow Lite Interpreter
   - NSFW Image Classification
   - Confidence Scoring

3. **Native Android Layer**
   - MediaProjection API for screen capture
   - Foreground Service for background monitoring
   - Overlay Window for blur effects

4. **Platform Communication**
   - Method Channels for Flutter-Native bridge
   - Image data transfer
   - Permission handling

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.35.4 or higher
- Android SDK (minSdk: 21, targetSdk: 36)
- Java 17
- Android Studio or VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/naqi-app.git
   cd naqi-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add TensorFlow Lite Model**
   
   ⚠️ **IMPORTANT**: You must provide your own NSFW detection model
   
   - Download a TensorFlow Lite NSFW detection model
   - Place it in `assets/models/nsfw_model.tflite`
   - Recommended: [NSFW MobileNetV2](https://github.com/GantMan/nsfw_model)

4. **Build and run**
   ```bash
   # Debug mode
   flutter run

   # Release APK
   flutter build apk --release
   ```

## 📖 Usage

### Basic Usage

1. **Grant Permissions**: Allow screen capture and overlay permissions
2. **Toggle Filter**: Use the main toggle to activate protection
3. **Adjust Sensitivity**: Choose Low, Medium, or High sensitivity
4. **Monitor Stats**: View filtered content count

### Parental Control

1. Navigate to Settings
2. Set a 4-digit PIN
3. Enable Parental Lock
4. Settings are now protected by PIN

### Quiet Mode

Enable Quiet Mode in settings to prevent notifications when content is filtered.

## 🔧 Configuration

### Sensitivity Levels

- **Low**: Only highly explicit content (threshold: 0.8)
- **Medium**: Moderate filtering (threshold: 0.6)
- **High**: Aggressive filtering (threshold: 0.4)

### Auto-start on Boot

The app automatically starts monitoring when your device boots if the filter was active.

## 🏗️ Project Structure

```
lib/
├── l10n/
│   └── app_localizations.dart    # Arabic/English translations
├── models/
│   └── app_state.dart             # App state management
├── screens/
│   ├── home_screen.dart           # Main app screen
│   └── settings_screen.dart       # Settings screen
├── services/
│   ├── nsfw_detector.dart         # TensorFlow Lite integration
│   ├── screen_capture_platform.dart # Native platform bridge
│   └── screen_monitoring_service.dart # Background service
└── main.dart                      # App entry point

android/
└── app/src/main/kotlin/com/example/flutter_app/
    ├── MainActivity.kt            # Main activity with MethodChannel
    ├── ScreenCaptureService.kt    # Screen capture service
    └── BootReceiver.kt            # Boot receiver for auto-start
```

## 🔐 Privacy & Security

- **No Internet Required**: All processing happens locally
- **No Data Collection**: No user data is collected or transmitted
- **No Cloud Storage**: Images are processed in memory and never saved
- **Open Source**: Fully transparent implementation

## ⚠️ Important Notes

### Model Requirements

This app requires a TensorFlow Lite model for NSFW detection. Due to ethical and licensing considerations, we cannot include a pre-trained model in the repository. You must:

1. Obtain or train your own model
2. Ensure it's compatible with TensorFlow Lite
3. Follow ethical guidelines for content filtering

### Native Implementation Status

The current implementation includes:
- ✅ Complete Flutter UI and state management
- ✅ TensorFlow Lite integration framework
- ✅ Background service architecture
- ✅ Native Android service skeleton
- ⚠️ MediaProjection API requires user permission
- ⚠️ Blur overlay requires additional native implementation

For full functionality, additional native Android development is needed for:
- Real-time screen capture
- Overlay window with blur effects
- Image data transfer optimization

## 🛠️ Development

### Building for Release

```bash
# Build APK
flutter build apk --release

# Build App Bundle for Play Store
flutter build appbundle --release
```

### Running Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📧 Contact

- Email: support@naqi.app
- GitHub: [@yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- TensorFlow team for TensorFlow Lite
- Open source community for various packages used

---

**Made with ❤️ for digital wellbeing and family safety**
