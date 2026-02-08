import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import 'rewards_screen.dart';
import 'pet_management_screen.dart';
import 'profile_management_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Profile Management"),
            leading: const Icon(Icons.person),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileManagementScreen()),
            ),
          ),
          ListTile(
            title: const Text("Pet Management"),
            leading: const Icon(Icons.pets),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PetManagementScreen()),
            ),
          ),
          ListTile(
            title: const Text("Rewards & Certificates"),
            leading: const Icon(Icons.card_membership),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RewardsScreen()),
            ),
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => ListTile(
              title: const Text("Dark Mode"),
              leading: const Icon(Icons.dark_mode),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (_) => themeProvider.toggleTheme(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}
