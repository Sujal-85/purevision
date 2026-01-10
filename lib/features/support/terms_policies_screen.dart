import 'package:flutter/material.dart';

class TermsPoliciesScreen extends StatelessWidget {
  const TermsPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Policies'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView(
        children: const [
          _PolicyItem(title: 'Terms of Use'),
          Divider(),
          _PolicyItem(title: 'Privacy Policy'),
          Divider(),
          _PolicyItem(title: 'Returns Policy'),
          Divider(),
          _PolicyItem(title: 'Cancellation & Refund Policy'),
          Divider(),
          _PolicyItem(title: 'Shipping Policy'),
          Divider(),
          _PolicyItem(title: 'Grievance Redressal Policy'),
          Divider(),
          _PolicyItem(title: 'EPR Compliance'),
        ],
      ),
    );
  }
}

class _PolicyItem extends StatelessWidget {
  final String title;
  const _PolicyItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      onTap: () {
        // In a real app, this would open a WebView or a detailed text screen
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Opening $title...')));
      },
    );
  }
}
