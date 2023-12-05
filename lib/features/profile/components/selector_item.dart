import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/assets_images.dart';

import '../../../common/constants/app_constants.dart';

class SelectorItem extends StatelessWidget {
  final String title;

  const SelectorItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 50,
      width: 74,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.selectorImage), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: AppStyles.mont11Bold.withColor(Colors.white))
        ],
      ),
    );
  }
}
