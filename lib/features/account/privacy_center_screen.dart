import 'package:flutter/material.dart';

class PrivacyCenterScreen extends StatelessWidget {
  const PrivacyCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Center'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView(
        children: [
          _buildHeader(),
          _buildSectionHeader('Manage Your Data'),
          _buildListTile(
            Icons.history,
            'Browsing History',
            'View or clear your browsing history',
          ),
          _buildListTile(
            Icons.search,
            'Search History',
            'View or clear your search history',
          ),
          _buildListTile(
            Icons.location_on_outlined,
            'Location History',
            'Manage saved locations and permissions',
          ),
          _buildListTile(
            Icons.devices,
            'Device Activity',
            'Manage devices logged into your account',
          ),

          const Divider(height: 32),

          _buildSectionHeader('Privacy Settings'),
          _buildListTile(
            Icons.lock_outline,
            'Account Security',
            'Password, 2FA, and login alerts',
          ),
          _buildListTile(
            Icons.ads_click,
            'Ad Preferences',
            'Control the ads you see',
          ),
          _buildListTile(
            Icons.person_off_outlined,
            'Request Account Deletion',
            'Permanently delete your account',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.grey[100],
      child: const Column(
        children: [
          Icon(Icons.privacy_tip_outlined, size: 48, color: Colors.black54),
          SizedBox(height: 16),
          Text(
            'We value your privacy',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Control how your data is used and manage your privacy settings.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: () {},
    );
  }
}
