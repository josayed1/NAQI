import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Naqi - Pure View',
      'filter_active': 'Filter Active',
      'filter_inactive': 'Filter Inactive',
      'turn_on': 'Turn On',
      'turn_off': 'Turn Off',
      'sensitivity': 'Sensitivity',
      'low': 'Low',
      'medium': 'Medium',
      'high': 'High',
      'filtered_count': 'Filtered Scenes',
      'quiet_mode': 'Quiet Mode',
      'quiet_mode_desc': 'No notifications when filtering',
      'parental_control': 'Parental Control',
      'set_pin': 'Set PIN',
      'enter_pin': 'Enter PIN',
      'confirm_pin': 'Confirm PIN',
      'pin_mismatch': 'PINs do not match',
      'pin_required': 'PIN required',
      'screen_cleaned': 'Screen cleaned - Naqi Active 🌿',
      'notification_title': 'Naqi Protection',
      'notification_desc': 'Screen monitoring active',
      'grant_permission': 'Grant Permission',
      'permission_required': 'Screen capture permission required',
      'permission_desc': 'Naqi needs permission to monitor and filter screen content',
      'settings': 'Settings',
      'about': 'About',
      'privacy': 'All processing happens locally on your device',
      'version': 'Version',
    },
    'ar': {
      'app_name': 'نقي - عرض نقي',
      'filter_active': 'الفلتر مفعّل',
      'filter_inactive': 'الفلتر متوقف',
      'turn_on': 'تشغيل',
      'turn_off': 'إيقاف',
      'sensitivity': 'الحساسية',
      'low': 'منخفضة',
      'medium': 'متوسطة',
      'high': 'عالية',
      'filtered_count': 'المشاهد المفلترة',
      'quiet_mode': 'وضع الهدوء',
      'quiet_mode_desc': 'بدون إشعارات عند الفلترة',
      'parental_control': 'التحكم الأبوي',
      'set_pin': 'تعيين الرمز',
      'enter_pin': 'أدخل الرمز',
      'confirm_pin': 'تأكيد الرمز',
      'pin_mismatch': 'الرموز غير متطابقة',
      'pin_required': 'الرمز مطلوب',
      'screen_cleaned': 'تم تنظيف الشاشة - نقي مفعّل 🌿',
      'notification_title': 'حماية نقي',
      'notification_desc': 'مراقبة الشاشة مفعّلة',
      'grant_permission': 'منح الإذن',
      'permission_required': 'إذن التقاط الشاشة مطلوب',
      'permission_desc': 'يحتاج نقي إلى إذن لمراقبة وفلترة محتوى الشاشة',
      'settings': 'الإعدادات',
      'about': 'حول',
      'privacy': 'تتم جميع المعالجات محلياً على جهازك',
      'version': 'الإصدار',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String get appName => translate('app_name');
  String get filterActive => translate('filter_active');
  String get filterInactive => translate('filter_inactive');
  String get turnOn => translate('turn_on');
  String get turnOff => translate('turn_off');
  String get sensitivity => translate('sensitivity');
  String get low => translate('low');
  String get medium => translate('medium');
  String get high => translate('high');
  String get filteredCount => translate('filtered_count');
  String get quietMode => translate('quiet_mode');
  String get quietModeDesc => translate('quiet_mode_desc');
  String get parentalControl => translate('parental_control');
  String get setPin => translate('set_pin');
  String get enterPin => translate('enter_pin');
  String get confirmPin => translate('confirm_pin');
  String get pinMismatch => translate('pin_mismatch');
  String get pinRequired => translate('pin_required');
  String get screenCleaned => translate('screen_cleaned');
  String get notificationTitle => translate('notification_title');
  String get notificationDesc => translate('notification_desc');
  String get grantPermission => translate('grant_permission');
  String get permissionRequired => translate('permission_required');
  String get permissionDesc => translate('permission_desc');
  String get settings => translate('settings');
  String get about => translate('about');
  String get privacy => translate('privacy');
  String get version => translate('version');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
