import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmergencyDetailsScreen extends StatelessWidget {
  final String emergencyType;

  const EmergencyDetailsScreen({super.key, required this.emergencyType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$emergencyType Details"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Provide Details (Optional)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Send location and description
                if (kDebugMode) {
                  print("SOS triggered for $emergencyType");
                }
              },
              icon: const Icon(Icons.send),
              label: const Text("Send Help Request"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
