import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_provider.dart';
import '../utils/app_localizations.dart';
import '../widgets/filter_toggle_card.dart';
import '../widgets/sensitivity_slider.dart';
import '../widgets/statistics_card.dart';
import '../widgets/settings_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final locale = AppLocalizations(appProvider.language);
        final isRTL = appProvider.language == 'ar';

        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.appName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    locale.appSubtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF3CB371),
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () => _showAboutDialog(context, locale),
                ),
              ],
            ),
            body: SafeArea(
              child: appProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Filter Toggle Card
                          FilterToggleCard(
                            isEnabled: appProvider.isFilterEnabled,
                            onToggle: () => appProvider.toggleFilter(),
                            locale: locale,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Sensitivity Slider
                          if (appProvider.isFilterEnabled)
                            SensitivitySlider(
                              sensitivity: appProvider.sensitivity,
                              onChanged: (value) => appProvider.setSensitivity(value),
                              locale: locale,
                            ),
                          
                          if (appProvider.isFilterEnabled)
                            const SizedBox(height: 16),
                          
                          // Statistics Card
                          StatisticsCard(
                            filteredCount: appProvider.filteredCount,
                            onReset: () => _showResetDialog(context, appProvider, locale),
                            locale: locale,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Settings List
                          SettingsList(
                            silentMode: appProvider.silentMode,
                            parentMode: appProvider.parentMode,
                            language: appProvider.language,
                            onSilentModeToggle: () => appProvider.toggleSilentMode(),
                            onParentModeToggle: () => _handleParentMode(context, appProvider, locale),
                            onLanguageChange: (lang) => appProvider.setLanguage(lang),
                            locale: locale,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, AppLocalizations locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF90EE90).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.water_drop,
                color: Color(0xFF3CB371),
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            Text(locale.about),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(locale.aboutText),
            const SizedBox(height: 16),
            Text(
              '${locale.version}: 1.0.0',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(locale.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, AppProvider appProvider, AppLocalizations locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.resetCount),
        content: const Text('هل أنت متأكد من إعادة تعيين العداد؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(locale.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              appProvider.resetFilteredCount();
              Navigator.pop(context);
            },
            child: Text(locale.translate('reset')),
          ),
        ],
      ),
    );
  }

  void _handleParentMode(BuildContext context, AppProvider appProvider, AppLocalizations locale) {
    if (appProvider.parentMode) {
      // Disable parent mode - verify PIN
      _showPinDialog(
        context,
        locale.translate('enter_pin'),
        (pin) {
          if (appProvider.verifyParentPin(pin)) {
            appProvider.setParentMode(false, null);
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(locale.translate('wrong_pin'))),
            );
          }
        },
        locale,
      );
    } else {
      // Enable parent mode - set PIN
      _showSetPinDialog(context, appProvider, locale);
    }
  }

  void _showPinDialog(
    BuildContext context,
    String title,
    Function(String) onSubmit,
    AppLocalizations locale,
  ) {
    final pinController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 4,
          decoration: const InputDecoration(
            hintText: '****',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(locale.translate('cancel')),
          ),
          TextButton(
            onPressed: () => onSubmit(pinController.text),
            child: Text(locale.translate('ok')),
          ),
        ],
      ),
    );
  }

  void _showSetPinDialog(BuildContext context, AppProvider appProvider, AppLocalizations locale) {
    final pinController = TextEditingController();
    final confirmController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.translate('set_pin')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: locale.translate('set_pin'),
                hintText: '****',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: locale.translate('confirm_pin'),
                hintText: '****',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(locale.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              if (pinController.text == confirmController.text &&
                  pinController.text.length == 4) {
                appProvider.setParentMode(true, pinController.text);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(locale.translate('pin_not_match'))),
                );
              }
            },
            child: Text(locale.translate('save')),
          ),
        ],
      ),
    );
  }
}
