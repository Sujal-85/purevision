import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 1,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Account Settings'),
          _buildListTile(Icons.person_outline, 'Edit Profile', () {}),
          _buildListTile(Icons.lock_outline, 'Change Password', () {}),
          _buildListTile(Icons.language, 'Select Language', () {}),

          _buildSectionHeader('Notifications'),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text('Push Notifications'),
            activeThumbColor: AppColors.primaryBlue,
          ),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text('Email Notifications'),
            activeThumbColor: AppColors.primaryBlue,
          ),

          _buildSectionHeader('More'),
          _buildListTile(Icons.description_outlined, 'Privacy Policy', () {}),
          _buildListTile(Icons.info_outline, 'About Us', () {}),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}
