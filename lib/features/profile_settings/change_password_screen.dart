import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';

import '../../common/components/yellow_submit_button.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import '../profile/cubit/user_cubit.dart';
import 'common/text_field_decoration.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        elevation: 2,
        centerTitle: false,
        title: const Text("Change password", style: AppStyles.mont23SemiBold),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Center(
              child: Image.asset(
                Assets.backBtn,
                height: 22,
                color: Colors.white,
              ),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                controller: currentPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder(
                        requiredMessage: "Current password is required")
                    .minLength(6, 'Must contain at least 6 characters')
                    .build(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration:
                    DecorationTF.decorationProfileTF("Current password"),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: true,
                controller: newPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder(
                        requiredMessage: "New password is required")
                    .minLength(6, 'Must contain at least 6 characters')
                    .build(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: DecorationTF.decorationProfileTF("New password"),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: true,
                controller: confirmNewPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder(
                        requiredMessage: "Confirmation password is required")
                    .minLength(6, 'Must contain at least 6 characters')
                    .build(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration:
                    DecorationTF.decorationProfileTF("New confirm password"),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 32,
              ),
              YellowSubmitButton(
                loading: false,
                buttonText: "Save",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (newPasswordController.text ==
                        confirmNewPasswordController.text) {
                      context.read<UserCubit>().changePassword(
                          currentPw: currentPasswordController.text,
                          newPw: newPasswordController.text);
                    } else {
                      EasyLoading.showError('Confirmation password mismatch');
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
