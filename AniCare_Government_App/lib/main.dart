import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_navigation.dart';
import 'services/auth_service.dart';
import 'services/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: In a real app, you'd initialize Firebase here
  // await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const AniCareApp(),
    ),
  );
}

class AniCareApp extends StatelessWidget {
  const AniCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    
    return MaterialApp(
      title: 'Ani-Care Gov+NGO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: Consumer<AuthService>(
        builder: (context, auth, _) {
          return auth.isAuthenticated ? const MainNavigation() : const LoginScreen();
        },
      ),
    );
  }
}
