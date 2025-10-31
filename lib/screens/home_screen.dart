import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../services/filter_service.dart';
import 'settings_screen.dart';
import 'parental_control_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    final filterService = Provider.of<FilterService>(context, listen: false);
    final isRTL = appState.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isRTL ? 'نقي - Naqi' : 'Naqi - Pure',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Logo
                _buildLogo(),
                const SizedBox(height: 24),
                
                // Main Filter Toggle Card
                _buildMainToggleCard(context, appState, filterService, isRTL),
                const SizedBox(height: 16),
                
                // Sensitivity Control Card
                _buildSensitivityCard(context, appState, isRTL),
                const SizedBox(height: 16),
                
                // Statistics Card
                _buildStatisticsCard(context, appState, isRTL),
                const SizedBox(height: 16),
                
                // Quick Settings
                _buildQuickSettings(context, appState, isRTL),
                const SizedBox(height: 16),
                
                // Parental Control
                _buildParentalControlButton(context, appState, isRTL),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildLogo() {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF90EE90).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.water_drop,
          size: 60,
          color: Color(0xFF3CB371),
        ),
      ),
    );
  }
  
  Widget _buildMainToggleCard(
    BuildContext context,
    AppStateProvider appState,
    FilterService filterService,
    bool isRTL,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              isRTL ? 'حالة الفلتر' : 'Filter Status',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appState.isFilterActive
                    ? const Color(0xFF3CB371).withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
              ),
              child: Center(
                child: Icon(
                  appState.isFilterActive ? Icons.shield : Icons.shield_outlined,
                  size: 60,
                  color: appState.isFilterActive
                      ? const Color(0xFF3CB371)
                      : Colors.grey,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              appState.isFilterActive
                  ? (isRTL ? 'الفلتر نشط 🌿' : 'Filter Active 🌿')
                  : (isRTL ? 'الفلتر متوقف' : 'Filter Inactive'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: appState.isFilterActive
                    ? const Color(0xFF3CB371)
                    : Colors.grey,
              ),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () async {
                if (!appState.isFilterActive) {
                  // Start monitoring
                  final success = await filterService.startMonitoring();
                  if (success) {
                    appState.toggleFilter();
                    if (!appState.isQuietMode && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isRTL
                              ? '✅ تم تفعيل الفلتر'
                              : '✅ Filter activated'),
                          backgroundColor: const Color(0xFF3CB371),
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isRTL
                              ? '❌ فشل في تفعيل الفلتر'
                              : '❌ Failed to activate filter'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                } else {
                  // Stop monitoring
                  await filterService.stopMonitoring();
                  appState.toggleFilter();
                  if (!appState.isQuietMode && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isRTL
                            ? '⏸️ تم إيقاف الفلتر'
                            : '⏸️ Filter deactivated'),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appState.isFilterActive
                    ? Colors.grey
                    : const Color(0xFF3CB371),
                foregroundColor: Colors.white,
              ),
              child: Text(
                appState.isFilterActive
                    ? (isRTL ? 'إيقاف الفلتر' : 'Stop Filter')
                    : (isRTL ? 'تشغيل الفلتر' : 'Start Filter'),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSensitivityCard(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isRTL ? 'مستوى الحساسية' : 'Sensitivity Level',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isRTL
                  ? 'مستوى عالي = فلترة أكثر صرامة'
                  : 'Higher = More strict filtering',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                const Icon(Icons.tune, color: Color(0xFF3CB371)),
                Expanded(
                  child: Slider(
                    value: appState.sensitivity,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: '${(appState.sensitivity * 100).toInt()}%',
                    activeColor: const Color(0xFF3CB371),
                    onChanged: (value) {
                      appState.updateSensitivity(value);
                    },
                  ),
                ),
                Text(
                  '${(appState.sensitivity * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3CB371),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatisticsCard(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              isRTL ? 'الإحصائيات' : 'Statistics',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.filter_alt,
                  label: isRTL ? 'تم التنظيف' : 'Filtered',
                  value: appState.filteredCount.toString(),
                ),
                _buildStatItem(
                  icon: Icons.schedule,
                  label: isRTL ? 'منذ' : 'Since',
                  value: isRTL ? 'اليوم' : 'Today',
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            TextButton.icon(
              onPressed: () {
                appState.resetFilteredCount();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isRTL
                        ? '✅ تم إعادة تعيين العداد'
                        : '✅ Counter reset'),
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
              label: Text(isRTL ? 'إعادة تعيين' : 'Reset'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 32, color: const Color(0xFF3CB371)),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3CB371),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuickSettings(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isRTL ? 'إعدادات سريعة' : 'Quick Settings',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            SwitchListTile(
              title: Text(isRTL ? 'وضع الهدوء' : 'Quiet Mode'),
              subtitle: Text(
                isRTL
                    ? 'بدون إشعارات'
                    : 'No notifications',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              value: appState.isQuietMode,
              activeColor: const Color(0xFF3CB371),
              onChanged: (value) {
                appState.toggleQuietMode();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildParentalControlButton(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    return Card(
      color: appState.isParentalControlEnabled
          ? const Color(0xFF3CB371).withOpacity(0.1)
          : null,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ParentalControlScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                appState.isParentalControlEnabled
                    ? Icons.lock
                    : Icons.lock_open,
                size: 32,
                color: const Color(0xFF3CB371),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isRTL ? 'وضع الوالدين' : 'Parental Control',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appState.isParentalControlEnabled
                          ? (isRTL ? 'مفعّل برمز PIN' : 'Enabled with PIN')
                          : (isRTL ? 'غير مفعّل' : 'Not enabled'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
