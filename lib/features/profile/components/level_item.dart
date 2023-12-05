import 'package:flutter/material.dart';

import '../../../common/constants/app_constants.dart';

class LevelBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;

  const LevelBanner(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      height: 30,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Center(
          child: Row(
        children: [
          Text(title, style: AppStyles.inter14w500.withColor(textColor)),
          const SizedBox(
            width: 4,
          ),
          Text(subtitle, style: AppStyles.inter13w500.withColor(textColor)),
        ],
      )),
    );
  }
}
