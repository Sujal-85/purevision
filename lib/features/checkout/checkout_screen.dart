import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/notification_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../core/theme/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  late Razorpay _razorpay;
  String _paymentMethod = 'cod'; // 'cod' or 'razorpay'

  // Address Controllers
  final _nameController = TextEditingController(text: 'Sujal Kumar');
  final _addressController = TextEditingController(text: '123, Tech Plaza');
  final _cityController = TextEditingController(text: 'Bangalore');
  final _zipController = TextEditingController(text: '560001');

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Navigate to Order Success / Orders Screen
    NotificationService().showNotification(
      id: 2,
      title: 'Order Placed Successfully! 📦',
      body: 'Your order has been confirmed. Tap to track.',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful: ${response.paymentId}')),
    );
    context.go('/orders'); // Replace with success screen ideally
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet: ${response.walletName}')),
    );
  }

  void _openRazorpay() {
    var options = {
      'key': 'rzp_test_12345678901234', // Replace with valid test Key
      'amount': (widget.totalAmount * 100).toInt(), // in paise
      'name': 'PureVision',
      'description': 'Order Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9988776655', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            _processPayment();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentOrange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_currentStep == 2 ? 'Place Order' : 'Continue'),
                  ),
                ),
                if (_currentStep > 0) const SizedBox(width: 12),
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  ),
              ],
            ),
          );
        },
        steps: [
          // Step 1: Address
          Step(
            title: const Text('Delivery Address'),
            content: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address Line 1',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _zipController,
                        decoration: const InputDecoration(labelText: 'Pincode'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),

          // Step 2: Order Summary
          Step(
            title: const Text('Order Summary'),
            content: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Items (2):'),
                      Text(
                        '₹${widget.totalAmount.toInt()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charge:'),
                      Text(
                        'FREE',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Payable:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '₹${widget.totalAmount.toInt()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.editing,
          ),

          // Step 3: Payment
          Step(
            title: const Text('Payment Options'),
            content: Column(
              children: [
                RadioListTile(
                  value: 'upi',
                  groupValue: _paymentMethod,
                  onChanged: (val) =>
                      setState(() => _paymentMethod = val.toString()),
                  title: const Text('UPI (Razorpay)'),
                  subtitle: const Text('Google Pay, PhonePe, Paytm'),
                  secondary: const Icon(
                    Icons.qr_code,
                    color: AppColors.primaryBlue,
                  ),
                ),
                RadioListTile(
                  value: 'cod',
                  groupValue: _paymentMethod,
                  onChanged: (val) =>
                      setState(() => _paymentMethod = val.toString()),
                  title: const Text('Cash on Delivery'),
                  secondary: const Icon(Icons.money, color: Colors.green),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
            state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    if (_paymentMethod == 'upi') {
      _openRazorpay();
    } else {
      // Mock COD Success
      // Verify Payment with Backend
      // await ApiService().createOrder({...});

      NotificationService().showNotification(
        id: 2,
        title: 'Order Placed Successfully! 📦',
        body: 'Your order has been confirmed. Tap to track.',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order Placed Successfully!')),
      );
      context.go('/orders');
    }
  }
}
