# NSFW Detection Model

## Required Model File

This application requires a TensorFlow Lite model for NSFW content detection.

### Model Download Instructions:

1. **Recommended Model: NSFW MobileNetV2**
   - Download from: https://github.com/GantMan/nsfw_model/releases
   - Model file: `nsfw_mobilenet_v2_224_1.tflite`
   - Place in: `assets/models/nsfw_model.tflite`

2. **Alternative: Use Teachable Machine**
   - Create custom model at: https://teachablemachine.withgoogle.com/
   - Export as TensorFlow Lite
   - Place in: `assets/models/nsfw_model.tflite`

### Model Specifications:
- Input: 224x224 RGB image
- Output: Classification scores for content categories
- Categories: Safe, NSFW (explicit content)

### Important Note:
Due to GitHub and ethical guidelines, we cannot include pre-trained NSFW detection models in the repository. Please download and add the model file manually.
