class DetectionResult {
  final bool isNsfw;
  final double confidence;
  final String category;
  final List<TextDetection> textDetections;
  final bool containsTargetName;

  DetectionResult({
    required this.isNsfw,
    required this.confidence,
    required this.category,
    required this.textDetections,
    required this.containsTargetName,
  });

  bool shouldBlur() {
    return isNsfw || containsTargetName;
  }
}

class TextDetection {
  final String text;
  final double x;
  final double y;
  final double width;
  final double height;

  TextDetection({
    required this.text,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  bool containsName(String targetName) {
    return text.contains(targetName);
  }
}
