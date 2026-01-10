import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import '../../core/theme/app_colors.dart';
import 'models/order_model.dart';
import '../../core/services/notification_service.dart';

class OrderTrackingScreen extends StatefulWidget {
  final OrderModel order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _activeStep = 0;

  @override
  void initState() {
    super.initState();
    // determine mock step based on status
    switch (widget.order.status) {
      case OrderStatus.delivered:
        _activeStep = 3;
        break;
      case OrderStatus.outForDelivery:
      case OrderStatus.shipped:
        _activeStep = 2;
        break;
      case OrderStatus.packed:
        _activeStep = 1;
        break;
      case OrderStatus.ordered:
      default:
        _activeStep = 0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      widget.order.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order.productName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${widget.order.amount.toInt()}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Order ID: ${widget.order.id}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tracking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // Vertical Stepper
            IconStepper(
              direction: Axis.vertical,
              activeStepColor: AppColors.primaryBlue,
              stepColor: Colors.grey[300],
              lineColor: AppColors.primaryBlue,
              activeStep: _activeStep,
              icons: const [
                Icon(Icons.shopping_cart_checkout),
                Icon(Icons.inventory_2),
                Icon(Icons.local_shipping),
                Icon(Icons.check_circle),
              ],
              onStepReached: (index) {
                // Read-only for tracking
              },
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 60,
              ), // Align with stepper content roughly
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _StepLabel(
                    title: 'Ordered',
                    subtitle: 'Your order has been placed.',
                  ),
                  SizedBox(height: 45),
                  _StepLabel(
                    title: 'Packed',
                    subtitle: 'Seller has packed your order.',
                  ),
                  SizedBox(height: 45),
                  _StepLabel(
                    title: 'Shipped',
                    subtitle: ' Your item is on the way.',
                  ),
                  SizedBox(height: 45),
                  _StepLabel(
                    title: 'Delivered',
                    subtitle: 'Package delivered.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Needs Help Section
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // Trigger Mock Notification for "Help Request"
                  NotificationService().showNotification(
                    id: 4,
                    title: 'Support Ticket Created',
                    body:
                        'We have received your query for Order #${widget.order.id}.',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Support Request Sent')),
                  );
                },
                icon: const Icon(
                  Icons.help_outline,
                  color: AppColors.primaryBlue,
                ),
                label: const Text(
                  'Need Help with this Order?',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _StepLabel extends StatelessWidget {
  final String title;
  final String subtitle;
  const _StepLabel({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
