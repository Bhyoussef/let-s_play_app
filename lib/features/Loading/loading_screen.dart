import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: CircularProgressIndicator(
        color: AppColors.purple,
      )),
    );
  }
}
