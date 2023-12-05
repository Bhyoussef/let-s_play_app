
import 'package:flutter/material.dart';

import '../../../common/constants/app_constants.dart';

class DecorationTF {
  DecorationTF._();

  static InputDecoration decorationProfileTF(String placeholder) {
    return InputDecoration(
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1, color: Colors.red)),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1, color: Colors.red)),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(width: 0.5, color: Colors.black26),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1, color: AppColors.purple)),
      hintText: placeholder,
      hintStyle: TextStyle(color: Colors.black38),
    );
  }
}
