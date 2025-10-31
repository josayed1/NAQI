class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'app_name': 'نقي',
      'app_subtitle': 'حماية ذكية للمحتوى',
      'filter_status': 'حالة الفلتر',
      'filter_enabled': 'مفعّل',
      'filter_disabled': 'معطّل',
      'enable_filter': 'تفعيل الفلتر',
      'disable_filter': 'تعطيل الفلتر',
      'sensitivity': 'حساسية الكشف',
      'sensitivity_low': 'منخفضة',
      'sensitivity_medium': 'متوسطة',
      'sensitivity_high': 'عالية',
      'filtered_scenes': 'المشاهد المفلترة',
      'scenes': 'مشهد',
      'silent_mode': 'الوضع الصامت',
      'silent_mode_desc': 'إيقاف الإشعارات',
      'parent_mode': 'وضع الوالدين',
      'parent_mode_desc': 'حماية الإعدادات برمز PIN',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'arabic': 'العربية',
      'english': 'English',
      'about': 'حول التطبيق',
      'about_text': 'تطبيق نقي يوفر حماية ذكية للمحتوى باستخدام تقنيات التعلم الآلي للكشف عن المحتوى غير اللائق وتطبيق تعتيم تلقائي.',
      'version': 'الإصدار',
      'reset_count': 'إعادة تعيين العداد',
      'enter_pin': 'أدخل رمز PIN',
      'set_pin': 'تعيين رمز PIN',
      'confirm_pin': 'تأكيد رمز PIN',
      'wrong_pin': 'رمز PIN غير صحيح',
      'pin_not_match': 'رموز PIN غير متطابقة',
      'cancel': 'إلغاء',
      'ok': 'موافق',
      'save': 'حفظ',
      'reset': 'إعادة تعيين',
      'permission_required': 'صلاحية مطلوبة',
      'permission_screen_capture': 'يحتاج التطبيق إلى صلاحية التقاط الشاشة لمراقبة المحتوى',
      'grant_permission': 'منح الصلاحية',
      'service_running': 'الخدمة تعمل',
      'service_stopped': 'الخدمة متوقفة',
      'protect_message': 'نقي يحميك الآن 🌿',
    },
    'en': {
      'app_name': 'Naqi',
      'app_subtitle': 'Smart Content Protection',
      'filter_status': 'Filter Status',
      'filter_enabled': 'Enabled',
      'filter_disabled': 'Disabled',
      'enable_filter': 'Enable Filter',
      'disable_filter': 'Disable Filter',
      'sensitivity': 'Detection Sensitivity',
      'sensitivity_low': 'Low',
      'sensitivity_medium': 'Medium',
      'sensitivity_high': 'High',
      'filtered_scenes': 'Filtered Scenes',
      'scenes': 'scenes',
      'silent_mode': 'Silent Mode',
      'silent_mode_desc': 'Disable notifications',
      'parent_mode': 'Parent Mode',
      'parent_mode_desc': 'Protect settings with PIN',
      'settings': 'Settings',
      'language': 'Language',
      'arabic': 'العربية',
      'english': 'English',
      'about': 'About',
      'about_text': 'Naqi provides smart content protection using machine learning to detect inappropriate content and apply automatic blurring.',
      'version': 'Version',
      'reset_count': 'Reset Counter',
      'enter_pin': 'Enter PIN',
      'set_pin': 'Set PIN',
      'confirm_pin': 'Confirm PIN',
      'wrong_pin': 'Wrong PIN',
      'pin_not_match': 'PINs do not match',
      'cancel': 'Cancel',
      'ok': 'OK',
      'save': 'Save',
      'reset': 'Reset',
      'permission_required': 'Permission Required',
      'permission_screen_capture': 'App needs screen capture permission to monitor content',
      'grant_permission': 'Grant Permission',
      'service_running': 'Service Running',
      'service_stopped': 'Service Stopped',
      'protect_message': 'Naqi is protecting you now 🌿',
    },
  };

  String translate(String key) {
    return _localizedValues[languageCode]?[key] ?? key;
  }

  String get appName => translate('app_name');
  String get appSubtitle => translate('app_subtitle');
  String get filterStatus => translate('filter_status');
  String get filterEnabled => translate('filter_enabled');
  String get filterDisabled => translate('filter_disabled');
  String get enableFilter => translate('enable_filter');
  String get disableFilter => translate('disable_filter');
  String get sensitivity => translate('sensitivity');
  String get sensitivityLow => translate('sensitivity_low');
  String get sensitivityMedium => translate('sensitivity_medium');
  String get sensitivityHigh => translate('sensitivity_high');
  String get filteredScenes => translate('filtered_scenes');
  String get scenes => translate('scenes');
  String get silentMode => translate('silent_mode');
  String get silentModeDesc => translate('silent_mode_desc');
  String get parentMode => translate('parent_mode');
  String get parentModeDesc => translate('parent_mode_desc');
  String get settings => translate('settings');
  String get language => translate('language');
  String get arabic => translate('arabic');
  String get english => translate('english');
  String get about => translate('about');
  String get aboutText => translate('about_text');
  String get version => translate('version');
  String get resetCount => translate('reset_count');
  String get protectMessage => translate('protect_message');
}
