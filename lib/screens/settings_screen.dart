import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    final isRTL = appState.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isRTL ? 'الإعدادات' : 'Settings'),
        ),
        body: ListView(
          children: [
            // Language Section
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFF3CB371)),
              title: Text(isRTL ? 'اللغة' : 'Language'),
              subtitle: Text(isRTL ? 'العربية' : 'English'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                _showLanguageDialog(context, appState, isRTL);
              },
            ),
            const Divider(),
            
            // About Section
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF3CB371)),
              title: Text(isRTL ? 'حول التطبيق' : 'About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: isRTL ? 'نقي - Naqi' : 'Naqi - Pure',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.water_drop,
                    size: 48,
                    color: Color(0xFF3CB371),
                  ),
                  children: [
                    Text(
                      isRTL
                          ? 'تطبيق ذكي لفلترة المحتوى غير اللائق مع الحفاظ على الخصوصية. جميع المعالجات تتم محليًا على الجهاز.'
                          : 'Smart content filtering app with privacy protection. All processing happens locally on your device.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
            const Divider(),
            
            // Privacy Policy
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined, color: Color(0xFF3CB371)),
              title: Text(isRTL ? 'سياسة الخصوصية' : 'Privacy Policy'),
              onTap: () {
                _showPrivacyDialog(context, isRTL);
              },
            ),
            const Divider(),
            
            // Version Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 64,
                      color: Color(0xFF3CB371),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isRTL ? 'نقي - Naqi' : 'Naqi - Pure',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3CB371),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'v1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showLanguageDialog(BuildContext context, AppStateProvider appState, bool isRTL) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isRTL ? 'اختر اللغة' : 'Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('العربية'),
                value: 'ar',
                groupValue: appState.locale.languageCode,
                activeColor: const Color(0xFF3CB371),
                onChanged: (value) {
                  if (value != null) {
                    appState.changeLanguage(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: appState.locale.languageCode,
                activeColor: const Color(0xFF3CB371),
                onChanged: (value) {
                  if (value != null) {
                    appState.changeLanguage(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _showPrivacyDialog(BuildContext context, bool isRTL) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isRTL ? 'سياسة الخصوصية' : 'Privacy Policy'),
          content: SingleChildScrollView(
            child: Text(
              isRTL
                  ? '''
🔒 الخصوصية والأمان

تطبيق نقي يحترم خصوصيتك:

✅ جميع المعالجات محلية
لا يتم إرسال أي بيانات للخوادم. كل المعالجة تتم على جهازك.

✅ لا نجمع بياناتك
لا نقوم بجمع أو تخزين أي معلومات شخصية أو صور.

✅ مفتوح المصدر
الكود متاح للمراجعة لضمان الشفافية.

✅ التحكم الكامل
أنت من يتحكم في تشغيل وإيقاف الفلتر.
                  '''
                  : '''
🔒 Privacy & Security

Naqi app respects your privacy:

✅ All Processing is Local
No data is sent to servers. Everything happens on your device.

✅ We Don't Collect Data
We do not collect or store any personal information or images.

✅ Open Source
Code is available for review to ensure transparency.

✅ Full Control
You control when to enable or disable the filter.
                  ''',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                isRTL ? 'حسنًا' : 'OK',
                style: const TextStyle(color: Color(0xFF3CB371)),
              ),
            ),
          ],
        );
      },
    );
  }
}
