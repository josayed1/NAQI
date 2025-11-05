class DetectionResult {
  final bool isNsfw;
  final double confidence;
  final List<BoundingBox> sensitiveRegions;
  final bool hasTargetText; // For "يوسف" detection
  final List<BoundingBox> textRegions;
  
  DetectionResult({
    required this.isNsfw,
    required this.confidence,
    required this.sensitiveRegions,
    this.hasTargetText = false,
    this.textRegions = const [],
  });
}

class BoundingBox {
  final double x;
  final double y;
  final double width;
  final double height;
  final double confidence;
  
  BoundingBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.confidence = 1.0,
  });
}
