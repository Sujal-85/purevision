import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpansionTile(
            title: Text('How do I track my order?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Go to My Orders > Select Order > View Details to track your shipment in real-time.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('What is the return policy?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Most items are eligible for returns within 7-30 days of delivery. Please check the product page for specific return policies.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('How do I use a coupon?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'You can apply coupons at the checkout page. Select "Apply Coupon" and choose from available offers.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('My payment failed, what should I do?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'If money was deducted, it will be refunded within 5-7 business days. Please retry payment with a stable internet connection.',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Can I change my delivery address?'),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'You can change the address before the order is shipped. Go to My Orders > Select Order > Change Address.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
