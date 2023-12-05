import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class ButtonIcon extends StatelessWidget {
  final String title;
  final String icon;
  final Function callback;

  const ButtonIcon({Key? key, required this.title, required this.icon, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
            )
          ]),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () {
          callback();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 20,),
            const SizedBox(width: 8,),
            Text(title, style: AppStyles.inter14w500.withColor(AppColors.purple))
          ],
        ),
      ),
    );
  }
}
