import 'package:flutter/material.dart';
import 'package:lets_play/common/components/yellow_submit_button.dart';
import 'package:lets_play/common/constants/app_constants.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => (false)),
      child: Scaffold(
          body: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green,
              size: 120,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Transaction Completed successfully",
              textAlign: TextAlign.center,
              style: AppStyles.mont23SemiBold,
            ),
            const SizedBox(
              height: 32,
            ),
            YellowSubmitButton(
              buttonText: 'Go back to home',
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        ),
      ))),
    );
  }
}
