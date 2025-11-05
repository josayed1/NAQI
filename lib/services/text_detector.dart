import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../models/detection_result.dart';

class TextDetectorService {
  final TextRecognizer _textRecognizer;
  static final TextDetectorService _instance = TextDetectorService._internal();
  
  factory TextDetectorService() => _instance;
  
  TextDetectorService._internal() 
    : _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  /// Detect text in image and check for target name "يوسف"
  Future<List<TextDetection>> detectText(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      final List<TextDetection> detections = [];
      
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final text = line.text;
          final boundingBox = line.boundingBox;
          
          detections.add(TextDetection(
            text: text,
            x: boundingBox.left,
            y: boundingBox.top,
            width: boundingBox.width,
            height: boundingBox.height,
          ));
        }
      }
      
      if (kDebugMode && detections.isNotEmpty) {
        debugPrint('📝 Detected ${detections.length} text blocks');
        for (final detection in detections) {
          if (detection.containsName('يوسف') || detection.containsName('Youssef')) {
            debugPrint('   ⚠️ Found target name: ${detection.text}');
          }
        }
      }
      
      return detections;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Text detection error: $e');
      }
      return [];
    }
  }

  /// Check if text contains target name in Arabic or transliterated form
  bool containsTargetName(String text) {
    final normalizedText = text.toLowerCase();
    return normalizedText.contains('يوسف') || 
           normalizedText.contains('youssef') ||
           normalizedText.contains('yusuf') ||
           normalizedText.contains('yousef');
  }

  void dispose() {
    _textRecognizer.close();
  }
}
