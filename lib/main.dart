import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_colors.dart';
import 'providers/diet_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/onboarding/profile_setup.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/scanner/camera_screen.dart';
import 'presentation/screens/assistant/chat_screen.dart';
import 'presentation/screens/history/history_screen.dart'; // Added Final Phase

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DietProvider())],
      child: const DietOptima(),
    ),
  );
}

class DietOptima extends StatelessWidget {
  const DietOptima({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DietOptima',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        // Enhancement: Modern Google Fonts
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        // Enhancement: Smooth transitions between screens
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),

      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/onboarding': (context) => const ProfileSetupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/scanner': (context) => const CameraScreen(),
        '/assistant': (context) => const ChatScreen(),
        '/history': (context) =>
            const HistoryScreen(), // PHASE 6: History Route
      },
    );
  }
}
