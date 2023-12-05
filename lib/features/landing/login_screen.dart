import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/common/components/social_media_button.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/landing/cubit/auth_cubit.dart';
import 'package:lets_play/features/register/enums/social_media.dart';

import '../../utils/geoLocation.dart';
import '../../routes/routes_list.dart';
import '../profile/cubit/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthInitial) {
          EasyLoading.show(dismissOnTap: true);
        }

        if (state is SuccessLoginState) {
          EasyLoading.showSuccess(
            'Welcome back ${state.user.firstname}',
            duration: const Duration(seconds: 1),
          );
          await Future.delayed(const Duration(seconds: 1));
          final userPosition = await GeoUtils.getPositionIfEnabled();
          if (userPosition != null) {
            final userCubit = context.read<UserCubit>();
            userCubit.setProfile(isAuthed: true, userPosition: userPosition);
            Navigator.pushReplacementNamed(context, RouteList.homeBottomTabbar);
          } else {
            Navigator.pushReplacementNamed(context, RouteList.enableLocation);
          }
        }

        if (state is ErrorState) {
          EasyLoading.dismiss();
          EasyLoading.showError('You did not sign in correctly.');
        }
      },
      builder: (context, state) {
        return body();
      },
    );
  }

  Widget body() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/landing_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/images/close_button.png",
                      width: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Center(
                      child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.fitWidth,
                        ),
                        const Text("Sign in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w400)),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlign: TextAlign.center,
                          controller: phoneController,
                          validator: ValidationBuilder(
                                  requiredMessage:
                                      "Please enter your phone number")
                              .minLength(8, 'Invalid number')
                              .phone('Invalid number')
                              .build(),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Color(0x70511E9B), fontSize: 16),
                              hintText: "Phone",
                              fillColor: const Color(0xFFF4F4F4)),
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ValidationBuilder(
                                  requiredMessage: "Please enter your password")
                              .minLength(
                                  6, 'Must contain at least 6 characters')
                              .build(),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Color(0x70511E9B), fontSize: 16),
                              hintText: "Password",
                              fillColor: const Color(0xFFF4F4F4)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteList.forgotPasswordScreen);
                              },
                              child: const Text(
                                'Forgot password',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       "Remember Me",
                            //       style: TextStyle(
                            //           fontSize: 12, color: Colors.white),
                            //     ),
                            //     const SizedBox(
                            //       width: 8,
                            //     ),
                            //     Container(
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(6)),
                            //       width: 26,
                            //       height: 26,
                            //     )
                            //   ],
                            // )
                          ],
                        )
                      ],
                    ),
                  )),
                ),
                flex: 7,
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SocialMediaWidget(),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                            phoneController.text,
                                            passwordController.text);
                                      } else {
                                        EasyLoading.showError(
                                            'Validate the inputs please',
                                            dismissOnTap: true,
                                            duration:
                                                const Duration(seconds: 2));
                                      }
                                    },
                                    child: const Text(
                                      'SIGN IN',
                                      style: AppStyles.largeButtonTextStyle,
                                    ),
                                    style:
                                        AppStyles.elevatedButtonDefaultStyle),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account ? ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/register');
                                        },
                                        child: Text("Sign up",
                                            style:
                                                AppStyles.textButtonTextStyle(
                                                    fontSize: 13)))
                                  ],
                                )
                              ]),
                        ),
                      )
                    ]),
                flex: 5,
              )
            ]),
          ),
        ));
  }
}

class SocialMediaWidget extends StatelessWidget {
  final bool dark;

  const SocialMediaWidget({Key? key, this.dark = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(children: [
            Expanded(
              child: Container(
                height: 1,
                color: dark ? AppColors.purple : Colors.white.withOpacity(0.84),
              ),
            ),
            SizedBox(
              child: Text(
                "OR",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: dark ? Colors.black : Colors.white, fontSize: 19),
              ),
              width: 56,
            ),
            Expanded(
              child: Container(
                height: 1,
                color: dark ? AppColors.purple : Colors.white.withOpacity(0.84),
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SocialMediaButton(
                socialMedia: SocialMedia.google,

              ),
              SocialMediaButton(
                socialMedia: SocialMedia.apple,
              ),
              SocialMediaButton(
                socialMedia: SocialMedia.facebook,
              )
            ],
          ),
        ),
      ],
    );
  }
}
