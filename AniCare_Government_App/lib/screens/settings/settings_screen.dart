import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../services/auth_service.dart';
import '../../services/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(auth),
          const SizedBox(height: 24),
          _buildSectionTitle('Account'),
          _buildSettingItem(Icons.person_outline, 'Profile Details', 'Update government/NGO profile'),
          _buildSettingItem(Icons.business_outlined, 'Department Details', 'Manage your organization info'),
          const SizedBox(height: 24),
          _buildSectionTitle('Appearance'),
          _buildSettingItem(
            Icons.dark_mode_outlined,
            'Dark Mode',
            'Toggle light/dark theme',
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(value),
              activeColor: AppTheme.primaryTeal,
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Security'),
          _buildSettingItem(Icons.lock_outline, 'Change Password', 'Keep your account secure'),
          _buildSettingItem(Icons.fingerprint, 'Face Authentication', 'Enable biometric login', trailing: Switch(value: true, onChanged: (v) {})),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => auth.logout(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[50],
              foregroundColor: Colors.red,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AuthService auth) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 35,
          backgroundColor: AppTheme.primaryTeal,
          child: Icon(Icons.person, size: 40, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(auth.userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(auth.role.toString().split('.').last.toUpperCase(), style: const TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.w500)),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppTheme.primaryTeal),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle, {Widget? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.primaryTeal, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: trailing == null ? () {} : null,
    );
  }
}
