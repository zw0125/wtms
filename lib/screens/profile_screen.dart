import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtms/model/workers.dart';
import 'package:wtms/screens/login_screen.dart';
import 'package:wtms/screens/task_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Worker worker;

  const ProfileScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Clear shared preferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('saved_email');
              await prefs.remove('saved_password');
              await prefs.setBool('remember_me', false);
              await prefs.clear();

              // Navigate to login screen
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileItem('Worker ID', '${worker.id}'),
            _buildProfileItem('Full Name', worker.fullName),
            _buildProfileItem('Email', worker.email),
            _buildProfileItem('Phone', worker.phone ?? 'Not provided'),
            _buildProfileItem('Address', worker.address ?? 'Not provided'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListScreen(worker: worker),
                  ),
                );
              },
              child: const Text('View My Tasks'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
