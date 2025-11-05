import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../screens/parent_lock_screen.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        final isLocked = state.settings.parentModeEnabled;
        
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الإعدادات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Sensitivity Slider
                _buildSensitivitySlider(context, state, isLocked),
                
                const Divider(height: 32),
                
                // Quiet Mode Toggle
                _buildQuietModeToggle(context, state, isLocked),
                
                const Divider(height: 32),
                
                // Parent Mode Toggle
                _buildParentModeToggle(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSensitivitySlider(BuildContext context, AppState state, bool isLocked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.tune, color: Color(0xFF3CB371), size: 20),
            const SizedBox(width: 8),
            const Text(
              'مستوى الحساسية',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              '${(state.settings.sensitivity * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF3CB371),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF3CB371),
            inactiveTrackColor: const Color(0xFF90EE90).withValues(alpha: 0.3),
            thumbColor: const Color(0xFF3CB371),
            overlayColor: const Color(0xFF3CB371).withValues(alpha: 0.2),
          ),
          child: Slider(
            value: state.settings.sensitivity,
            min: 0.3,
            max: 0.95,
            divisions: 13,
            onChanged: isLocked
                ? null
                : (value) async {
                    await state.updateSensitivity(value);
                  },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'منخفض',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              'متوسط',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              'عالي',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuietModeToggle(BuildContext context, AppState state, bool isLocked) {
    return Row(
      children: [
        const Icon(Icons.notifications_off, color: Color(0xFF3CB371), size: 20),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الوضع الصامت',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                'إخفاء الإشعارات',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: state.settings.quietMode,
          onChanged: isLocked
              ? null
              : (value) async {
                  await state.toggleQuietMode(value);
                },
          activeThumbColor: const Color(0xFF3CB371),
        ),
      ],
    );
  }

  Widget _buildParentModeToggle(BuildContext context, AppState state) {
    return Row(
      children: [
        const Icon(Icons.lock_outline, color: Color(0xFF3CB371), size: 20),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'وضع الوالدين',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                'قفل الإعدادات برمز PIN',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: state.settings.parentModeEnabled,
          onChanged: (value) {
            if (value) {
              // Show PIN setup dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParentLockScreen(isSetup: true),
                ),
              );
            } else {
              // Verify PIN before disabling
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParentLockScreen(isDisabling: true),
                ),
              );
            }
          },
          activeThumbColor: const Color(0xFF3CB371),
        ),
      ],
    );
  }
}
