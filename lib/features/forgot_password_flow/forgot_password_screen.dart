import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lets_play/common/components/yellow_submit_button.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/common/constants/constants.dart';
import 'package:lets_play/features/landing/cubit/auth_cubit.dart';
import 'package:lets_play/features/register/enums/register_flow.dart';
import 'package:lets_play/features/register/mixin/register_flow_mixin.dart';
import 'package:lets_play/features/register/register_body/otp_screen_body.dart';
import 'package:lets_play/features/register/register_body/phone_screen_body.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../routes/routes_list.dart';
import 'new_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with RegisterFlowStepMixin {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpPinsController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final TextEditingController retypePasswordController = TextEditingController();

  final _passwordFlow = [
    ForgotPSWDFlow.phone,
    ForgotPSWDFlow.otp,
    ForgotPSWDFlow.password,
  ];

  int _currentStepIndex = 0;

  @override
  void initState() {
    _currentStepIndex = 0;
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    errorController.close();

    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _currentStepIndex = page;
    });
  }

  void _animateTo(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: TextButton(
              onPressed: () {
                _handleBackButton(context);
              },
              child: Image.asset(
                "assets/images/back_button.png",
                width: 20,
              ))),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthInitial) {
              EasyLoading.show(dismissOnTap: true);
            }

            if (state is SuccessSentOtpState) {
              EasyLoading.showSuccess('Sms successfully sent.',
                  duration: const Duration(seconds: 1));
              if (state.resend == false) _animateTo(_currentStepIndex + 1);
            }

            if (state is SuccessCreatePasswordState) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Password successfully created.',
                  duration: const Duration(seconds: 1));
              Navigator.pushReplacementNamed(context, RouteList.homeBottomTabbar);
            }

            if (state is ErrorState) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error);
            }
          },
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Forgot password",
                style:
                    TextStyle(color: AppColors.purple, fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: onPageChanged,
                  itemCount: _passwordFlow.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: _getWidgetFromFlow(_passwordFlow[index]),
                    );
                  }),
              flex: 8,
            ),
            YellowSubmitButton(
              loading: false,
              buttonText: _passwordFlow[_currentStepIndex].submitButtonText,
              onPressed: () {
                _handleNextButton(_passwordFlow[_currentStepIndex]);
              },
            )
          ]),
        ),
      ),
    );
  }

  void _handleBackButton(BuildContext context) {
    if (_currentStepIndex != 0) {
      _animateTo(_currentStepIndex - 1);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void canProceedToNextStep() {}

  void _handleNextButton(ForgotPSWDFlow forgotPasswordFlow) {
    final authCubit = context.read<AuthCubit>();

    if (forgotPasswordFlow == ForgotPSWDFlow.phone) {
      if (!phoneFormKey.currentState!.validate()) return;
      authCubit.generateOtp(phoneController.text, PASSWORD);
      otpPinsController.clear();
    } else if (forgotPasswordFlow == ForgotPSWDFlow.otp) {
      if (otpPinsController.text.length != 4 ||
          authCubit.currentFormState.otp.toString() != otpPinsController.text) {
        errorController.add(ErrorAnimationType.shake);
      } else {
        _animateTo(_currentStepIndex + 1);
      }
    } else if (forgotPasswordFlow == ForgotPSWDFlow.password) {
      if (!passwordFormKey.currentState!.validate()) return;
      if (passwordController.text == retypePasswordController.text) {
        authCubit.createNewPassword(
            phone: phoneController.text,
            otp: otpPinsController.text,
            newPassword: passwordController.text,
            newConfirmPassword: retypePasswordController.text);
      } else {
        EasyLoading.showError('Password field and retype password must match',
            duration: const Duration(seconds: 1));
      }
    }
  }

  _getWidgetFromFlow(ForgotPSWDFlow forgotPasswordFlow) {
    switch (forgotPasswordFlow) {
      case ForgotPSWDFlow.phone:
        return PhoneScreenBody(
          registerFlowMixin: this,
          phoneFormKey: phoneFormKey,
          phoneController: phoneController,
          isForgotPassword: true,
        );
      case ForgotPSWDFlow.otp:
        return OTPScreenBody(
          registerFlowMixin: this,
          otpPinsController: otpPinsController,
          errorController: errorController,
        );

      case ForgotPSWDFlow.password:
        return NewPasswordScreen(
          registerFlowMixin: this,
          passwordController: passwordController,
          retypePasswordController: retypePasswordController,
          passwordFormKey: passwordFormKey,
        );
      default:
        return Container();
    }
  }
}

class StepsLinearProgress extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  const StepsLinearProgress({Key? key, required this.currentStep, required this.totalSteps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "$currentStep of $totalSteps",
            style: const TextStyle(
                color: Color(0xFF989898), fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          LinearProgressIndicator(
            minHeight: 1,
            value: currentStep / totalSteps,
            color: Colors.black,
            backgroundColor: const Color(0xFFD1D1D1),
          ),
        ],
      ),
    );
  }
}
