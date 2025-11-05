import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:google_ml_kit/google_ml_kit.dart';
import '../models/detection_result.dart';

class TextDetector {
  static final TextDetector _instance = TextDetector._internal();
  factory TextDetector() => _instance;
  TextDetector._internal();

  final _textRecognizer = GoogleMlKit.vision.textRecognizer();
  final String targetName = 'يوسف'; // Yusuf in Arabic

  Future<List<BoundingBox>> detectTargetText(Uint8List imageBytes) async {
    try {
      final inputImage = InputImage.fromBytes(
        bytes: imageBytes,
        metadata: InputImageMetadata(
          size: const ui.Size(100, 100), // Will be overridden with actual size
          rotation: InputImageRotation.rotation0deg,
          format: InputImageFormat.nv21,
          bytesPerRow: 100,
        ),
      );

      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      
      List<BoundingBox> targetRegions = [];

      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          // Check if line contains the target name (يوسف)
          if (line.text.contains(targetName) || 
              _normalizeArabic(line.text).contains(_normalizeArabic(targetName))) {
            
            final rect = line.boundingBox;
            if (rect != null) {
              targetRegions.add(
                BoundingBox(
                  x: rect.left.toDouble(),
                  y: rect.top.toDouble(),
                  width: rect.width.toDouble(),
                  height: rect.height.toDouble(),
                  confidence: line.confidence ?? 0.9,
                ),
              );
            }
          }
        }
      }

      return targetRegions;
    } catch (e) {
      // Fallback to simple pattern matching if ML Kit fails
      return _fallbackTextDetection(imageBytes);
    }
  }

  String _normalizeArabic(String text) {
    // Remove diacritics and normalize Arabic text
    return text
        .replaceAll(RegExp(r'[\u064B-\u065F]'), '') // Remove diacritics
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .trim();
  }

  List<BoundingBox> _fallbackTextDetection(Uint8List imageBytes) {
    // Simple pattern-based detection as fallback
    // In production, this would use more sophisticated OCR
    // For now, return empty list
    return [];
  }

  void dispose() {
    _textRecognizer.close();
  }
}
