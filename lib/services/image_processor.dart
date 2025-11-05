import 'dart:typed_data';
import 'package:image/image.dart' as img;
import '../models/detection_result.dart';

class ImageProcessor {
  static final ImageProcessor _instance = ImageProcessor._internal();
  factory ImageProcessor() => _instance;
  ImageProcessor._internal();

  /// Apply blur to sensitive regions and text regions
  Uint8List applyBlur(
    Uint8List imageBytes,
    DetectionResult detectionResult,
    int blurIntensity,
  ) {
    try {
      final image = img.decodeImage(imageBytes);
      if (image == null) return imageBytes;

      // Blur sensitive regions (NSFW content)
      for (final region in detectionResult.sensitiveRegions) {
        _blurRegion(
          image,
          region,
          blurIntensity: blurIntensity,
        );
      }

      // Blur text regions (يوسف)
      for (final region in detectionResult.textRegions) {
        _blurRegion(
          image,
          region,
          blurIntensity: blurIntensity ~/ 2, // Lighter blur for text
        );
      }

      // Encode back to bytes
      return Uint8List.fromList(img.encodeJpg(image, quality: 85));
    } catch (e) {
      // If processing fails, return original image
      return imageBytes;
    }
  }

  void _blurRegion(
    img.Image image,
    BoundingBox region,
    {required int blurIntensity},
  ) {
    // Calculate region bounds
    final x = region.x.toInt().clamp(0, image.width - 1);
    final y = region.y.toInt().clamp(0, image.height - 1);
    final width = region.width.toInt().clamp(1, image.width - x);
    final height = region.height.toInt().clamp(1, image.height - y);

    // Extract the region using copyCrop (image 3.x positional parameters)
    final regionImg = img.copyCrop(image, x, y, width, height);

    // Apply Gaussian blur (image 3.x API: first param is image, second is radius)
    final blurred = img.gaussianBlur(regionImg, blurIntensity);

    // Composite the blurred region back onto the original image
    img.copyInto(image, blurred, dstX: x, dstY: y);
  }

  /// Apply pixelation effect instead of blur
  Uint8List applyPixelation(
    Uint8List imageBytes,
    DetectionResult detectionResult,
    int pixelSize,
  ) {
    try {
      final image = img.decodeImage(imageBytes);
      if (image == null) return imageBytes;

      // Pixelate sensitive regions
      for (final region in detectionResult.sensitiveRegions) {
        _pixelateRegion(image, region, pixelSize: pixelSize);
      }

      // Pixelate text regions
      for (final region in detectionResult.textRegions) {
        _pixelateRegion(image, region, pixelSize: pixelSize ~/ 2);
      }

      return Uint8List.fromList(img.encodeJpg(image, quality: 85));
    } catch (e) {
      return imageBytes;
    }
  }

  void _pixelateRegion(
    img.Image image,
    BoundingBox region,
    {required int pixelSize},
  ) {
    final x = region.x.toInt().clamp(0, image.width - 1);
    final y = region.y.toInt().clamp(0, image.height - 1);
    final width = region.width.toInt().clamp(1, image.width - x);
    final height = region.height.toInt().clamp(1, image.height - y);

    // Simple pixelation by downscaling and upscaling
    final regionImg = img.copyCrop(image, x, y, width, height);

    // Downscale
    final downscaled = img.copyResize(
      regionImg,
      width: (width / pixelSize).round().clamp(1, width),
      height: (height / pixelSize).round().clamp(1, height),
      interpolation: img.Interpolation.nearest,
    );

    // Upscale back
    final pixelated = img.copyResize(
      downscaled,
      width: width,
      height: height,
      interpolation: img.Interpolation.nearest,
    );

    // Composite back
    img.copyInto(image, pixelated, dstX: x, dstY: y);
  }

  /// Create a mask overlay for sensitive regions
  img.Image createMask(
    int width,
    int height,
    List<BoundingBox> regions,
  ) {
    final mask = img.Image(width, height);
    img.fill(mask, img.getColor(0, 0, 0)); // Black background

    for (final region in regions) {
      final x = region.x.toInt().clamp(0, width - 1);
      final y = region.y.toInt().clamp(0, height - 1);
      final w = region.width.toInt().clamp(1, width - x);
      final h = region.height.toInt().clamp(1, height - y);

      // Fill region with white
      img.fillRect(
        mask,
        x,
        y,
        x + w,
        y + h,
        img.getColor(255, 255, 255),
      );
    }

    return mask;
  }
}
