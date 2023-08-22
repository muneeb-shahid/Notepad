import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/EmailVerificationController/EmailVerificationController.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    EmailVerificationController emailVerificationController =
        Get.put(EmailVerificationController());
    return Scaffold(
      // ... existing code ...

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed:emailVerificationController.checkEmailVerification,
              child: Text('Check Verification'),
            ),
          ),
        ],
      ),
    );
  }
}
