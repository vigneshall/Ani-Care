import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 80, color: AppColors.primary),
            const SizedBox(height: 16),
            const Text("Ani-Care", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const Text("Caring for our stray friends", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 48),
            const TextField(
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.read<AuthProvider>().login("test@example.com", "password"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
