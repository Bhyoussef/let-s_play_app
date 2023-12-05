import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/constants.dart';
import 'package:lets_play/features/register/mixin/register_flow_mixin.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../data/core/appEnv.dart';
import '../../landing/cubit/auth_cubit.dart';

class OTPScreenBody extends RegisterFlowBody {
  const OTPScreenBody({
    Key? key,
    required RegisterFlowStepMixin registerFlowMixin,
    required this.otpPinsController,
    required this.errorController,
    this.isForgotPassword = false
  }) : super(key: key, registerFlowMixin: registerFlowMixin);
  final TextEditingController otpPinsController;
  final StreamController<ErrorAnimationType> errorController;
  final bool isForgotPassword;
  @override
  State<OTPScreenBody> createState() => _OTPScreenBodyState();
}

class _OTPScreenBodyState extends State<OTPScreenBody>
    with AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    print('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final authCubit = context.read<AuthCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Confirm your number by entering the 4 digit code sent to ${AppEnvState.mobilePrefix} ${authCubit.currentFormState.phone}",
              style: const TextStyle(fontSize: 15)),
          const SizedBox(
            height: 60,
          ),
          Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 3,
                      fieldHeight: 55,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                      inactiveColor: const Color(0xffD1D1D1),
                      selectedColor: const Color(0xffD1D1D1),
                      disabledColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor: Colors.black,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    cursorColor: Colors.black,
                    controller: widget.otpPinsController,
                    errorAnimationController: widget.errorController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onCompleted: (pin) {
                      print("Completed");
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Pasted $text");

                      return true;
                    },
                  ))),
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () {
                authCubit.generateOtp(authCubit.currentFormState.phone!,
                    resend: true, widget.isForgotPassword ? PASSWORD : REGISTRATION);
              },
              child: Text(
                "Resend code",
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.purple,
                    fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class OTPFormInput extends StatefulWidget {
  final Function(String) onEditingCompleted;

  const OTPFormInput({Key? key, required this.onEditingCompleted})
      : super(key: key);

  @override
  State<OTPFormInput> createState() => _OTPFormInputState();
}

class _OTPFormInputState extends State<OTPFormInput> {
  String _pin1 = "";
  String _pin2 = "";
  String _pin3 = "";
  String _pin4 = "";

  @override
  void initState() {
    super.initState();
  }

  void _validateForm() {
    if (_pin1.isNotEmpty &&
        _pin2.isNotEmpty &&
        _pin3.isNotEmpty &&
        _pin4.isNotEmpty) {
      widget.onEditingCompleted("$_pin1$_pin2$_pin3$_pin4");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          OTPPinTextForm(
            onNextFocus: (pin) {
              setState(() {
                _pin1 = pin;
              });
            },
          ),
          OTPPinTextForm(
            onNextFocus: (pin) {
              setState(() {
                _pin2 = pin;
              });
            },
          ),
          OTPPinTextForm(
            onNextFocus: (pin) {
              setState(() {
                _pin3 = pin;
              });
            },
          ),
          OTPPinTextForm(
            onNextFocus: (pin) {
              setState(() {
                _pin4 = pin;
              });
              _validateForm();
            },
          ),
        ]);
  }
}

class OTPPinTextForm extends StatelessWidget {
  final Function(String) onNextFocus;

  const OTPPinTextForm({Key? key, required this.onNextFocus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 30,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            onNextFocus(value);
            FocusScope.of(context).nextFocus();
          }
        },
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD1D1D1)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
