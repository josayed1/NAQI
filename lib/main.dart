import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/filter_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
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
      title: 'نقي - Naqi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3CB371),
          primary: const Color(0xFF3CB371),
          secondary: const Color(0xFF90EE90),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF3CB371),
          elevation: 0,
        ),
      ),
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      home: const HomeScreen(),
    );
  }
}
