import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/app_state.dart';
import '../l10n/app_localizations.dart';
import '../services/screen_capture_platform.dart';
import '../services/screen_monitoring_service.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _checkPermissions();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.systemAlertWindow.status;
    setState(() {
      _hasPermissions = status.isGranted;
    });
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.systemAlertWindow.request();
    setState(() {
      _hasPermissions = status.isGranted;
    });

    if (!status.isGranted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).permissionDesc),
          action: SnackBarAction(
            label: AppLocalizations.of(context).settings,
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Title
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3CB371), Color(0xFF90EE90)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.appName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
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
                const SizedBox(height: 32),

                // Main Status Card
                Card(
                  elevation: 0,
                  color: appState.isFilterActive
                      ? const Color(0xFF3CB371).withValues(alpha: 0.1)
                      : theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: appState.isFilterActive
                                      ? [
                                          const Color(0xFF3CB371),
                                          const Color(0xFF90EE90),
                                        ]
                                      : [
                                          Colors.grey.shade300,
                                          Colors.grey.shade400,
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: appState.isFilterActive
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF3CB371)
                                              .withValues(alpha: _pulseController.value),
                                          blurRadius: 20,
                                          spreadRadius: 10,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Icon(
                                appState.isFilterActive
                                    ? Icons.shield_outlined
                                    : Icons.shield,
                                size: 60,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          appState.isFilterActive
                              ? l10n.filterActive
                              : l10n.filterInactive,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: appState.isFilterActive
                                ? const Color(0xFF3CB371)
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.tonal(
                          onPressed: () async {
                            if (!_hasPermissions) {
                              await _requestPermissions();
                              if (!_hasPermissions) return;
                            }
                            
                            // Toggle filter state
                            await appState.toggleFilter();
                            
                            // Start or stop screen monitoring
                            if (appState.isFilterActive) {
                              // Request screen capture permission
                              final messenger = ScaffoldMessenger.of(context);
                              final permission = await ScreenCapturePlatform.requestPermission();
                              if (permission) {
                                await ScreenMonitoringService.start();
                              } else {
                                // Revert filter state if permission denied
                                await appState.toggleFilter();
                                if (mounted) {
                                  messenger.showSnackBar(
                                    SnackBar(content: Text(l10n.permissionRequired)),
                                  );
                                }
                              }
                            } else {
                              await ScreenMonitoringService.stop();
                              await ScreenCapturePlatform.stopCapture();
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: appState.isFilterActive
                                ? theme.colorScheme.errorContainer
                                : const Color(0xFF3CB371),
                            foregroundColor: appState.isFilterActive
                                ? theme.colorScheme.onErrorContainer
                                : Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            appState.isFilterActive ? l10n.turnOff : l10n.turnOn,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sensitivity Control
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.sensitivity,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SegmentedButton<SensitivityLevel>(
                          segments: [
                            ButtonSegment(
                              value: SensitivityLevel.low,
                              label: Text(l10n.low),
                            ),
                            ButtonSegment(
                              value: SensitivityLevel.medium,
                              label: Text(l10n.medium),
                            ),
                            ButtonSegment(
                              value: SensitivityLevel.high,
                              label: Text(l10n.high),
                            ),
                          ],
                          selected: {appState.sensitivity},
                          onSelectionChanged: (Set<SensitivityLevel> newSelection) {
                            appState.setSensitivity(newSelection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Statistics
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.filter_alt_outlined,
                        label: l10n.filteredCount,
                        value: appState.filteredCount.toString(),
                        color: const Color(0xFF3CB371),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.notifications_off_outlined,
                        label: l10n.quietMode,
                        value: appState.quietMode ? '✓' : '✗',
                        color: appState.quietMode
                            ? const Color(0xFF3CB371)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Privacy Notice
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.lock_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.privacy,
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 13,
                          ),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
