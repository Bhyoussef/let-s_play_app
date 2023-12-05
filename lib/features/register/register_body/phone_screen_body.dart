import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/register/mixin/register_flow_mixin.dart';

import '../../../data/core/appEnv.dart';

class PhoneScreenBody extends RegisterFlowBody {
  const PhoneScreenBody({
    Key? key,
    required RegisterFlowStepMixin registerFlowMixin,
    required this.phoneFormKey,
    required this.phoneController,
    this.isForgotPassword = false
  }) : super(key: key, registerFlowMixin: registerFlowMixin);
  final GlobalKey<FormState> phoneFormKey;
  final TextEditingController phoneController;
  final bool isForgotPassword;
  @override
  State<PhoneScreenBody> createState() => _PhoneScreenBodyState();
}

class _PhoneScreenBodyState extends State<PhoneScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.phoneFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Enter your mobile number, and we’ll send a code to confirm it.",
              style: TextStyle(fontSize: 15)),
          Expanded(
              child: Center(
                  child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: TextFormField(
                controller: widget.phoneController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: ValidationBuilder(
                        requiredMessage: "Please enter your phone number")
                    .minLength(8, 'Invalid number')
                    .phone('Invalid number')
                    .build(),
                decoration: const InputDecoration.collapsed(
                        hintText: '1234 5678',
                        hintStyle: TextStyle(color: Color(0x66D1D1D1)))
                    .copyWith(
                  prefixIcon: const Text(
                    "${AppEnvState.mobilePrefix}  ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))
            ],
          ))),
          if(!widget.isForgotPassword)TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Have an account?",
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.purple,
                    fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }
}
