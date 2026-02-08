import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alerts")),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            title: Text("High Risk Prediction"),
            subtitle: Text("Health risk in Navi Mumbai area has increased."),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: Colors.green),
            title: Text("Reward Unlocked!"),
            subtitle: Text("You've earned 10 points for your last rescue."),
          ),
        ],
      ),
    );
  }
}
