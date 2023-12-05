import 'package:flutter/material.dart';

import '../../../../common/constants/app_constants.dart';
import '../../../../common/constants/assets_images.dart';

class EmptyPLayerPlaceholder extends StatelessWidget {
  const EmptyPLayerPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      width: 51,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              Assets.playerPlaceholder,
            )),
      ),
      child: Icon(
        Icons.add,
        size: 20,
        color: AppColors.purple,
      ),
    );
  }
}
