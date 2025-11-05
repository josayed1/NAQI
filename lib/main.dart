import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/filter_service.dart';
import 'services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  final settingsService = SettingsService();
  await settingsService.initialize();
  
  final filterService = FilterService();
  await filterService.initialize();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: filterService),
        Provider.value(value: settingsService),
      ],
      child: const NaqiApp(),
    ),
  );
}

class NaqiApp extends StatelessWidget {
  const NaqiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naqi – نقي',
      debugShowCheckedModeBanner: false,
      
      // RTL Support for Arabic
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'), // Arabic
        Locale('en', 'US'), // English
      ],
      locale: const Locale('ar', 'SA'),
      
      // Material 3 Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3CB371), // Medium Sea Green
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3CB371),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3CB371),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF3CB371),
          foregroundColor: Colors.white,
        ),
        // RTL text direction
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Arial'),
          displayMedium: TextStyle(fontFamily: 'Arial'),
          displaySmall: TextStyle(fontFamily: 'Arial'),
          headlineLarge: TextStyle(fontFamily: 'Arial'),
          headlineMedium: TextStyle(fontFamily: 'Arial'),
          headlineSmall: TextStyle(fontFamily: 'Arial'),
          bodyLarge: TextStyle(fontFamily: 'Arial'),
          bodyMedium: TextStyle(fontFamily: 'Arial'),
          bodySmall: TextStyle(fontFamily: 'Arial'),
        ),
      ),
      
      home: const HomeScreen(),
    );
  }
}
