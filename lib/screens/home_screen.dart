import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';
import 'settings_screen.dart';
import 'test_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsService = Provider.of<SettingsService>(context, listen: false);
    final settings = settingsService.getSettings();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'نقي – Naqi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFF90EE90).withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.water_drop_outlined,
                          size: 60,
                          color: Color(0xFF3CB371),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'حماية ذكية',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3CB371),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'تصفية محتوى تلقائية بالذكاء الاصطناعي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Main Toggle Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'التصفية النشطة',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'تفعيل الحماية التلقائية',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: settings.isFilterEnabled,
                              activeTrackColor: const Color(0xFF3CB371),
                              onChanged: (value) async {
                                await settingsService.toggleFilter(value);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        if (settings.isFilterEnabled) ...[
                          const Divider(height: 32),
                          const Text(
                            'مستوى الحساسية',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('منخفض'),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: const Color(0xFF3CB371),
                                    thumbColor: const Color(0xFF3CB371),
                                  ),
                                  child: Slider(
                                    value: settings.sensitivity,
                                    min: 0.3,
                                    max: 1.0,
                                    divisions: 7,
                                    label: '${(settings.sensitivity * 100).round()}%',
                                    onChanged: (value) async {
                                      await settingsService.setSensitivity(value);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              const Text('عالي'),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Statistics Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          size: 48,
                          color: Color(0xFF3CB371),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'المحتوى المحظور',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${settings.filteredScenesCount}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3CB371),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'مشهد تم تصفيته',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Test Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TestScreen()),
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text(
                    'اختبار التصفية',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 12),

                // Status Indicator
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: settings.isFilterEnabled 
                        ? const Color(0xFF90EE90).withValues(alpha: 0.2)
                        : Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        settings.isFilterEnabled ? Icons.check_circle : Icons.cancel,
                        color: settings.isFilterEnabled 
                            ? const Color(0xFF3CB371) 
                            : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        settings.isFilterEnabled 
                            ? 'الحماية مفعّلة 🌿'
                            : 'الحماية معطّلة',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: settings.isFilterEnabled 
                              ? const Color(0xFF3CB371) 
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
