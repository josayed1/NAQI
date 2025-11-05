import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsService = Provider.of<SettingsService>(context, listen: false);
    final settings = settingsService.getSettings();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Quiet Mode
              Card(
                child: SwitchListTile(
                  title: const Text(
                    'الوضع الصامت',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('إيقاف الإشعارات'),
                  value: settings.quietMode,
                  activeTrackColor: const Color(0xFF3CB371),
                  onChanged: (value) async {
                    await settingsService.toggleQuietMode(value);
                    setState(() {});
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Auto Start on Boot
              Card(
                child: SwitchListTile(
                  title: const Text(
                    'التشغيل التلقائي',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('تفعيل الحماية عند بدء الجهاز'),
                  value: settings.autoStartOnBoot,
                  activeTrackColor: const Color(0xFF3CB371),
                  onChanged: (value) async {
                    await settingsService.setAutoStart(value);
                    setState(() {});
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Parent Mode
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text(
                        'وضع الوالدين',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text('حماية الإعدادات برمز PIN'),
                      value: settings.parentModeEnabled,
                      activeTrackColor: const Color(0xFF3CB371),
                      onChanged: (value) async {
                        if (value) {
                          _showSetPinDialog();
                        } else {
                          if (settings.parentPin != null) {
                            _showVerifyPinDialog(() async {
                              await settingsService.setParentMode(false, null);
                              setState(() {});
                            });
                          } else {
                            await settingsService.setParentMode(false, null);
                            setState(() {});
                          }
                        }
                      },
                    ),
                    if (settings.parentModeEnabled && settings.parentPin != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showVerifyPinDialog(() {
                              _showSetPinDialog();
                            });
                          },
                          icon: const Icon(Icons.lock_reset),
                          label: const Text('تغيير رمز PIN'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Reset Counter
              Card(
                child: ListTile(
                  leading: const Icon(Icons.refresh, color: Color(0xFF3CB371)),
                  title: const Text(
                    'إعادة تعيين العداد',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('المحتوى المحظور: ${settings.filteredScenesCount}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          title: const Text('إعادة تعيين العداد'),
                          content: const Text('هل تريد إعادة تعيين عداد المحتوى المحظور؟'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('إلغاء'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('تأكيد'),
                            ),
                          ],
                        ),
                      ),
                    );

                    if (confirm == true) {
                      await settingsService.resetFilterCount();
                      setState(() {});
                    }
                  },
                ),
              ),

              const SizedBox(height: 24),

              // About Section
              Card(
                color: const Color(0xFF90EE90).withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.water_drop_outlined,
                        size: 48,
                        color: Color(0xFF3CB371),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Naqi – نقي',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3CB371),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'نسخة 1.0.0',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'حماية ذكية بتقنية الذكاء الاصطناعي\nتصفية محلية بدون إنترنت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSetPinDialog() {
    _pinController.clear();
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تعيين رمز PIN'),
          content: TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'رمز PIN (4 أرقام)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                final pin = _pinController.text;
                if (pin.length == 4) {
                  final settingsService = Provider.of<SettingsService>(context, listen: false);
                  await settingsService.setParentMode(true, pin);
                  setState(() {});
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تعيين رمز PIN بنجاح')),
                    );
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يجب إدخال 4 أرقام')),
                    );
                  }
                }
              },
              child: const Text('تأكيد'),
            ),
          ],
        ),
      ),
    );
  }

  void _showVerifyPinDialog(VoidCallback onSuccess) {
    _pinController.clear();
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('التحقق من رمز PIN'),
          content: TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'أدخل رمز PIN',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                final settingsService = Provider.of<SettingsService>(context, listen: false);
                if (settingsService.verifyParentPin(_pinController.text)) {
                  Navigator.pop(context);
                  onSuccess();
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('رمز PIN غير صحيح')),
                    );
                  }
                }
              },
              child: const Text('تأكيد'),
            ),
          ],
        ),
      ),
    );
  }
}
