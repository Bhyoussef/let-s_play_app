import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class YellowBanner extends StatelessWidget {
  final String title;

  const YellowBanner({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 20,
      decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Center(
        child:
            Text(title, style: AppStyles.inter12w500.withColor(Colors.black)),
      ),
    );
  }
}
