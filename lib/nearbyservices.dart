import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NearbyServices extends StatelessWidget {
  const NearbyServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Services'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // List of services
            Expanded(
              child: ListView(
                children: [
                  _buildServiceItem('Hospital', 'assets/hospital.png'),
                  _buildServiceItem('Police Station', 'assets/help-desk.png'),
                  _buildServiceItem('Restaurant', 'assets/restaurant.png'),
                  _buildServiceItem('ATM', 'assets/atm-machine.png'),
                  _buildServiceItem('Gas Station', 'assets/hotel.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String title, String iconPath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(
          iconPath,
          height: 40,
          width: 40,
        ),
        title: Text(title),
        onTap: () {
          // Handle tap for detailed information
          if (kDebugMode) {
            print('$title tapped');
          }
        },
      ),
    );
  }
}
