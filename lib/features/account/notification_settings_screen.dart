import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Mock Settings
  bool _orderUpdates = true;
  bool _promotions = true;
  bool _offers = true;
  bool _reminders = false;
  bool _feedUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoSection(),
          const Divider(height: 32),
          _buildSwitchTile(
            'Order Updates',
            'Get updates about your order status, delivery, and returns.',
            _orderUpdates,
            (val) => setState(() => _orderUpdates = val),
          ),
          _buildSwitchTile(
            'Promotions',
            'Receive exclusive offers, coupons, and sale alerts.',
            _promotions,
            (val) => setState(() => _promotions = val),
          ),
          _buildSwitchTile(
            'Offers & Rewards',
            'Get notified about SuperCoins, scratch cards, and rewards.',
            _offers,
            (val) => setState(() => _offers = val),
          ),
          _buildSwitchTile(
            'Reminders',
            'Price drops, back in stock, and items in cart.',
            _reminders,
            (val) => setState(() => _reminders = val),
          ),
          _buildSwitchTile(
            'Feed Updates',
            'Updates from brands and influencers you follow.',
            _feedUpdates,
            (val) => setState(() => _feedUpdates = val),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50], // Light blue info box
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.primaryBlue),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Manage your notifications to stay updated on what matters to you.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primaryBlue,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
