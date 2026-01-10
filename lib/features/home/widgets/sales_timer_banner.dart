import 'dart:async';
import 'package:flutter/material.dart';

class SalesTimerBanner extends StatefulWidget {
  final DateTime endTime;
  const SalesTimerBanner({super.key, required this.endTime});

  @override
  State<SalesTimerBanner> createState() => _SalesTimerBannerState();
}

class _SalesTimerBannerState extends State<SalesTimerBanner> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.endTime.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        final now = DateTime.now();
        if (widget.endTime.isBefore(now)) {
          _timeLeft = Duration.zero;
          _timer.cancel();
        } else {
          _timeLeft = widget.endTime.difference(now);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeft.inSeconds <= 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), // Light Blue
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=1000&auto=format&fit=crop',
          ), // Party/Confetti background
          opacity: 0.1,
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          // Left Side: Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BIG SAVINGS',
                  style: TextStyle(
                    color: Color(0xFF1565C0), // Dark Blue
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sales ends in:',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Right Side: Timer
          Row(
            children: [
              _buildTimeBox(
                _timeLeft.inHours.toString().padLeft(2, '0'),
                'Hrs',
              ),
              _buildSeparator(),
              _buildTimeBox(
                (_timeLeft.inMinutes % 60).toString().padLeft(2, '0'),
                'Min',
              ),
              _buildSeparator(),
              _buildTimeBox(
                (_timeLeft.inSeconds % 60).toString().padLeft(2, '0'),
                'Sec',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1565C0), // Dark Blue box
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        ':',
        style: TextStyle(
          color: Color(0xFF1565C0),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
