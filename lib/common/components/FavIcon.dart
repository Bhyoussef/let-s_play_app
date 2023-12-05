import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavWidget extends StatefulWidget {
  final bool selectedInitially;
  final ValueChanged<bool>? onChange;
  const FavWidget({this.selectedInitially = false, this.onChange});

  @override
  _FavWidgetState createState() => _FavWidgetState();
}

class _FavWidgetState extends State<FavWidget>
    with SingleTickerProviderStateMixin {
  bool? currentState;
  late AnimationController controller;
  late Animation animation;
  double variableValue = 0.0;

  @override
  void initState() {
    super.initState();
    currentState = widget.selectedInitially;
    controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.addListener(() {
      variableValue = animation.value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            currentState = !currentState!;
            if (currentState!) {
              controller.forward(from: 0.0);
            }
            widget.onChange!(currentState!);
          });
        },
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              // print(variableValue);
              return child!;
            },
            child: SizedBox(
              height: 40.h,
              width: 40.h,
              child: SizedBox(
                height: 40.h,
                width: 40.h,
                child: CircleAvatar(
                  radius: 25.sp,
                  backgroundColor: currentState!
                      ? AppColors.mainRed.withOpacity(0.1)
                      : AppColors.disabledGrey.withOpacity(0.1),
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    size: 23.sp,
                    color: currentState!
                        ? AppColors.mainRed
                        : AppColors.disabledGrey,
                  ),
                ),
              ),
            )));
  }
}
