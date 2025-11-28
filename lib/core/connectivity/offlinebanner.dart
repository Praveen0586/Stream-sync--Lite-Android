import 'package:flutter/material.dart';
import 'package:streamsync_lite/core/connectivity/connectivityService.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService().connectionStream,
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? true;

        if (isOnline) return SizedBox.shrink();

       return AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  child: isOnline
      ? const SizedBox.shrink()
      : Container(
          key: const ValueKey('offlineBanner'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "You're in Offline Mode",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
);

      },
    );
  }
}
