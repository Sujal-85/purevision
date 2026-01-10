import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AudioSearchDialog extends StatefulWidget {
  const AudioSearchDialog({super.key});

  @override
  State<AudioSearchDialog> createState() => _AudioSearchDialogState();
}

class _AudioSearchDialogState extends State<AudioSearchDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Listening...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Pulsing Animation
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryBlue.withOpacity(
                      0.2 * _controller.value + 0.1,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      height: 60 + (10 * _controller.value),
                      width: 60 + (10 * _controller.value),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryBlue,
                      ),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            Text(
              'Try saying "Blue T-shirt"',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
