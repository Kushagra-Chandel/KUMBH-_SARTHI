import 'package:flutter/material.dart';
import 'package:kumbh_sarthi/emergencydetails.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Assistance"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Emergency Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildEmergencyOption(
                    context,
                    icon: Icons.local_hospital,
                    label: "Medical Emergency",
                    onTap: () {
                      // Handle medical emergency
                      _navigateToDetails(context, "Medical Emergency");
                    },
                  ),
                  _buildEmergencyOption(
                    context,
                    icon: Icons.security,
                    label: "Theft",
                    onTap: () {
                      _navigateToDetails(context, "Theft");
                    },
                  ),
                  _buildEmergencyOption(
                    context,
                    icon: Icons.people,
                    label: "Brawl/Fight",
                    onTap: () {
                      _navigateToDetails(context, "Brawl/Fight");
                    },
                  ),
                  _buildEmergencyOption(
                    context,
                    icon: Icons.person_search,
                    label: "Lost Person",
                    onTap: () {
                      _navigateToDetails(context, "Lost Person");
                    },
                  ),
                  _buildEmergencyOption(
                    context,
                    icon: Icons.local_fire_department,
                    label: "Fire",
                    onTap: () {
                      _navigateToDetails(context, "Fire");
                    },
                  ),
                  _buildEmergencyOption(
                    context,
                    icon: Icons.error,
                    label: "Other Emergency",
                    onTap: () {
                      _navigateToDetails(context, "Other Emergency");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }

  void _navigateToDetails(BuildContext context, String emergencyType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EmergencyDetailsScreen(emergencyType: emergencyType),
      ),
    );
  }
}
