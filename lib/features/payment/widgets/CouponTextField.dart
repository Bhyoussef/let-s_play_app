import 'package:flutter/material.dart';

import '../../../common/constants/app_constants.dart';

class CouponTextField extends StatelessWidget {
  const CouponTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            enabledBorder: couponTextFieldBorder,
            focusedBorder: couponTextFieldBorder,
            border: couponTextFieldBorder,
            errorBorder: couponErroredTextFieldBorder,
            fillColor: Colors.white,
            focusColor: Colors.white,
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: GestureDetector(
              onTap: () {},
              child: Container(
                width: 110,
                decoration: const BoxDecoration(
                    border: Border(
                        left:
                            BorderSide(width: 1.0, color: Color(0xff707070)))),
                child: const Center(
                    child: Text('APPLY', style: AppStyles.inter15w500)),
              ),
            )),
      ),
    );
  }
}

final couponTextFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: const BorderSide(color: Color(0xff707070), width: 1.0));
final couponErroredTextFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 88, 24, 24), width: 1.0));
