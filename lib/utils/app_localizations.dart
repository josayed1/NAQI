import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Naqi - Pure',
      'filter_status': 'Filter Status',
      'filter_active': 'Filter Active 🌿',
      'filter_inactive': 'Filter Inactive',
      'start_filter': 'Start Filter',
      'stop_filter': 'Stop Filter',
      'sensitivity_level': 'Sensitivity Level',
      'statistics': 'Statistics',
      'filtered': 'Filtered',
      'since': 'Since',
      'today': 'Today',
      'reset': 'Reset',
      'quick_settings': 'Quick Settings',
      'quiet_mode': 'Quiet Mode',
      'no_notifications': 'No notifications',
      'parental_control': 'Parental Control',
      'enabled_with_pin': 'Enabled with PIN',
      'not_enabled': 'Not enabled',
      'settings': 'Settings',
      'language': 'Language',
      'about': 'About',
      'privacy_policy': 'Privacy Policy',
      'version': 'Version',
    },
    'ar': {
      'app_name': 'نقي',
      'filter_status': 'حالة الفلتر',
      'filter_active': 'الفلتر نشط 🌿',
      'filter_inactive': 'الفلتر متوقف',
      'start_filter': 'تشغيل الفلتر',
      'stop_filter': 'إيقاف الفلتر',
      'sensitivity_level': 'مستوى الحساسية',
      'statistics': 'الإحصائيات',
      'filtered': 'تم التنظيف',
      'since': 'منذ',
      'today': 'اليوم',
      'reset': 'إعادة تعيين',
      'quick_settings': 'إعدادات سريعة',
      'quiet_mode': 'وضع الهدوء',
      'no_notifications': 'بدون إشعارات',
      'parental_control': 'وضع الوالدين',
      'enabled_with_pin': 'مفعّل برمز PIN',
      'not_enabled': 'غير مفعّل',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'about': 'حول التطبيق',
      'privacy_policy': 'سياسة الخصوصية',
      'version': 'الإصدار',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
