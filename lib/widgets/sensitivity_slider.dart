import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';

class SensitivitySlider extends StatelessWidget {
  final double sensitivity;
  final ValueChanged<double> onChanged;
  final AppLocalizations locale;

  const SensitivitySlider({
    super.key,
    required this.sensitivity,
    required this.onChanged,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.tune,
                  color: Color(0xFF3CB371),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  locale.sensitivity,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Slider
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: const Color(0xFF3CB371),
                inactiveTrackColor: Colors.grey[300],
                thumbColor: const Color(0xFF3CB371),
                overlayColor: const Color(0xFF3CB371).withValues(alpha: 0.2),
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                ),
              ),
              child: Slider(
                value: sensitivity,
                min: 0.3,
                max: 0.9,
                divisions: 6,
                onChanged: onChanged,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel(locale.sensitivityLow, sensitivity <= 0.5),
                _buildLabel(locale.sensitivityMedium, sensitivity > 0.5 && sensitivity <= 0.7),
                _buildLabel(locale.sensitivityHigh, sensitivity > 0.7),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF90EE90).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Color(0xFF3CB371),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getSensitivityDescription(sensitivity, locale),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isActive) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        color: isActive ? const Color(0xFF3CB371) : Colors.grey[600],
      ),
    );
  }

  String _getSensitivityDescription(double value, AppLocalizations locale) {
    if (value <= 0.5) {
      return locale.language == 'ar'
          ? 'حساسية منخفضة - يكشف المحتوى الواضح فقط'
          : 'Low sensitivity - Detects only obvious content';
    } else if (value <= 0.7) {
      return locale.language == 'ar'
          ? 'حساسية متوسطة - توازن بين الدقة والخصوصية'
          : 'Medium sensitivity - Balance between accuracy and privacy';
    } else {
      return locale.language == 'ar'
          ? 'حساسية عالية - حماية قصوى مع احتمال كشف أوسع'
          : 'High sensitivity - Maximum protection with wider detection';
    }
  }
}
