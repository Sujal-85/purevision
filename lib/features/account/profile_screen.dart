import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black87,
            ),
            onPressed: () => context.push('/cart'), // Future link
          ),
        ],
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          // Fallback if no user matches or not logged in, though likely guarded by auth
          final name = user?.displayName ?? 'User';
          final email = user?.email ?? 'No Email';

          return ListView(
            children: [
              // Header: Login/User Info
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    // Avatar / Icon
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            email,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text(
                                'Explore',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      'Plus Silver',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 10,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Coin Balance
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.bolt, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '0',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(thickness: 1, height: 1),
              const SizedBox(height: 16),

              // Grid Options: Orders, Wishlist, Coupons, Help Center
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 3.5, // Wide rectangular buttons
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    _buildGridOption(
                      Icons.inventory_2_outlined,
                      'Orders',
                      () => context.push('/orders'),
                    ),
                    _buildGridOption(
                      Icons.favorite_border,
                      'Wishlist',
                      () => context.push('/wishlist'),
                    ),
                    _buildGridOption(
                      Icons.card_giftcard,
                      'Coupons',
                      () => context.push('/coupons'),
                    ),
                    _buildGridOption(
                      Icons.headset_mic_outlined,
                      'Help Center',
                      () => context.push('/complaints'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Divider(thickness: 4, color: AppColors.scaffoldBackground),

              // List Options
              _buildListOption(
                Icons.person_outline,
                'Edit Profile',
                onTap: () => context.push('/edit_profile'),
              ),
              _buildListOption(
                Icons.account_balance_wallet_outlined,
                'Saved Credit / Debit & Gift Cards', // Secure Vault
                onTap: () => context.push('/secure_vault'),
              ),
              _buildListOption(
                Icons.location_on_outlined,
                'Saved Addresses',
                onTap: () => context.push('/saved_addresses'),
              ),
              _buildListOption(
                Icons.translate,
                'Select Language',
                onTap: () => context.push('/language'),
              ),
              _buildListOption(
                Icons.notifications_none,
                'Notification Settings',
                onTap: () => context.push('/notification_settings'),
              ),
              _buildListOption(
                Icons.lock_outline,
                'Privacy Center',
                onTap: () => context.push('/privacy_center'),
              ),
              _buildListOption(
                Icons.settings_outlined,
                'App Settings',
                onTap: () => context.push('/settings'),
              ),

              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'My Activity',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              _buildListOption(
                Icons.edit_outlined,
                'Reviews',
                onTap: () => context.push('/my_reviews'),
              ),
              _buildListOption(
                Icons.question_answer_outlined,
                'Questions & Answers',
                onTap: () => context.push('/my_qa'),
              ),
              _buildListOption(
                Icons.feedback_outlined,
                'App Feedback',
                onTap: () => context.push('/feedback'),
              ),

              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Earn with Flipkart',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              _buildListOption(
                Icons.storefront_outlined,
                'Sell on Flipkart',
                onTap: () => context.push('/sell'),
              ),

              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Feedback & Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              _buildListOption(
                Icons.description_outlined,
                'Terms, Policies and Licenses',
                onTap: () => context.push('/terms'),
              ),
              _buildListOption(
                Icons.help_outline,
                'Browse FAQs',
                onTap: () => context.push('/faqs'),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(color: AppColors.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGridOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListOption(IconData icon, String label, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700], size: 22),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap ?? () {},
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
