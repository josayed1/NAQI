import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';

class SettingsList extends StatelessWidget {
  final bool silentMode;
  final bool parentMode;
  final String language;
  final VoidCallback onSilentModeToggle;
  final VoidCallback onParentModeToggle;
  final ValueChanged<String> onLanguageChange;
  final AppLocalizations locale;

  const SettingsList({
    super.key,
    required this.silentMode,
    required this.parentMode,
    required this.language,
    required this.onSilentModeToggle,
    required this.onParentModeToggle,
    required this.onLanguageChange,
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            // Silent Mode
            _buildSettingTile(
              icon: Icons.notifications_off,
              title: locale.silentMode,
              subtitle: locale.silentModeDesc,
              trailing: Switch(
                value: silentMode,
                onChanged: (_) => onSilentModeToggle(),
                activeTrackColor: const Color(0xFF3CB371),
              ),
            ),
            
            const Divider(height: 1),
            
            // Parent Mode
            _buildSettingTile(
              icon: Icons.lock,
              title: locale.parentMode,
              subtitle: locale.parentModeDesc,
              trailing: Switch(
                value: parentMode,
                onChanged: (_) => onParentModeToggle(),
                activeTrackColor: const Color(0xFF3CB371),
              ),
            ),
            
            const Divider(height: 1),
            
            // Language
            _buildSettingTile(
              icon: Icons.language,
              title: locale.language,
              subtitle: language == 'ar' ? locale.arabic : locale.english,
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: onLanguageChange,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'ar',
                    child: Row(
                      children: [
                        if (language == 'ar')
                          const Icon(
                            Icons.check,
                            color: Color(0xFF3CB371),
                            size: 20,
                          ),
                        if (language == 'ar') const SizedBox(width: 8),
                        Text(locale.arabic),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        if (language == 'en')
                          const Icon(
                            Icons.check,
                            color: Color(0xFF3CB371),
                            size: 20,
                          ),
                        if (language == 'en') const SizedBox(width: 8),
                        Text(locale.english),
                      ],
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

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF90EE90).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF3CB371),
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),
      trailing: trailing,
    );
  }
}
