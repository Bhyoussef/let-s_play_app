import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lets_play/common/components/MyNetworkImage.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/models/sport_category_model.dart';

class SportGridItemWidget extends StatelessWidget {
  const SportGridItemWidget({
    Key? key,
    required this.sport,
    required this.isSelected,
  }) : super(key: key);

  final SportCategoryModel sport;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              color: isSelected ? AppColors.purple : Colors.white, width: 2)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.h, right: 18.w),
            child: MyNetworkImage(
              picPath: sport.icon!,
              width: 46.w,
              height: 46.w,
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Text(sport.nameEn!.capitalize,
                    style: AppStyles.mont15Medium),
              )),
        ],
      ),
    );
  }
}
