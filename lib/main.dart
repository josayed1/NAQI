import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/settings_service.dart';
import 'services/app_provider.dart';
import 'services/screen_monitor_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize services
  final settingsService = await SettingsService.getInstance();
  await ScreenMonitorService.initialize();
  
  runApp(MyApp(settingsService: settingsService));
}

class MyApp extends StatelessWidget {
  final SettingsService settingsService;

  const MyApp({super.key, required this.settingsService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(settingsService),
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
            title: 'نقي - Naqi',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF3CB371),
                primary: const Color(0xFF3CB371),
                secondary: const Color(0xFF90EE90),
              ),
              useMaterial3: true,
              fontFamily: appProvider.language == 'ar' ? null : 'Roboto',
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
