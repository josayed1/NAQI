# NSFW Detection Model

This app uses TensorFlow Lite for content detection.

For actual deployment, you'll need to:
1. Train or download a pre-trained NSFW detection model (.tflite format)
2. Place it in this directory as `nsfw_model.tflite`
3. Update the labels file `labels.txt`

Recommended models:
- NSFW MobileNet model from GantMan/nsfw_model
- Yahoo Open NSFW model converted to TFLite

Note: The app includes a fallback detection mechanism that works with image analysis.
