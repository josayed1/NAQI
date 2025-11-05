import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../widgets/settings_card.dart';
import '../widgets/stats_card.dart';
import 'parent_lock_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // RTL for Arabic
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'نقي',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3CB371),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Naqi',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Consumer<AppState>(
              builder: (context, state, child) {
                if (state.settings.parentModeEnabled) {
                  return IconButton(
                    icon: const Icon(Icons.lock, color: Color(0xFF3CB371)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ParentLockScreen(),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: Consumer<AppState>(
          builder: (context, state, child) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3CB371),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // App Logo
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF3CB371).withValues(alpha: 0.2),
                          const Color(0xFF90EE90).withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      size: 80,
                      color: Color(0xFF3CB371),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Tagline
                  Text(
                    'حماية ذكية، محلية وآمنة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Stats Card
                  const StatsCard(),
                  
                  const SizedBox(height: 16),
                  
                  // Main Toggle
                  _buildMainToggle(context, state),
                  
                  const SizedBox(height: 16),
                  
                  // Settings Card
                  const SettingsCard(),
                  
                  const SizedBox(height: 32),
                  
                  // Info
                  _buildInfoSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainToggle(BuildContext context, AppState state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: state.settings.isFilterEnabled
              ? const LinearGradient(
                  colors: [Color(0xFF3CB371), Color(0xFF90EE90)],
                )
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تفعيل الحماية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: state.settings.isFilterEnabled
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.settings.isFilterEnabled
                        ? 'الخدمة نشطة الآن 🌿'
                        : 'الخدمة متوقفة',
                    style: TextStyle(
                      fontSize: 14,
                      color: state.settings.isFilterEnabled
                          ? Colors.white70
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: state.settings.isFilterEnabled,
              onChanged: state.settings.parentModeEnabled
                  ? null
                  : (value) async {
                      try {
                        await state.toggleFilter(value);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('فشل تفعيل الخدمة: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
              activeThumbColor: Colors.white,
              activeTrackColor: Colors.white.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF90EE90).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF3CB371),
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            'المعالجة المحلية بالكامل',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'جميع العمليات تتم على جهازك\nلا يتم إرسال أي بيانات للإنترنت',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
