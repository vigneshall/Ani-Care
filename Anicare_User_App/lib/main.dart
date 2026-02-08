import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/prediction_provider.dart';
import 'providers/pet_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/distress_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: Firebase initialization requires google-services.json / GoogleService-Info.plist
  // await Firebase.initializeApp(); 
  runApp(const AniCareApp());
}

class AniCareApp extends StatelessWidget {
  const AniCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PetProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DistressProvider()),
        ChangeNotifierProxyProvider<PetProvider, PredictionProvider>(
          create: (_) => PredictionProvider(),
          update: (_, petProvider, predictionProvider) {
            predictionProvider!.setPetProvider(petProvider);
            return predictionProvider;
          },
        ),
      ],
      child: Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, auth, theme, _) {
          return MaterialApp(
            title: 'Ani-Care',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme.themeMode,
            home: auth.isAuthenticated ? const MainNavigation() : const LoginScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
