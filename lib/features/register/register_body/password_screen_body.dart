import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/register/mixin/register_flow_mixin.dart';

class PasswordScreenBody extends RegisterFlowBody {

  const PasswordScreenBody({
    Key? key,
    required RegisterFlowStepMixin registerFlowMixin,
    required this.passwordFormKey,
    required this.passwordController,
  }) : super(key: key, registerFlowMixin: registerFlowMixin);
  final GlobalKey<FormState> passwordFormKey;
  final TextEditingController passwordController;

  @override
  State<PasswordScreenBody> createState() => _PasswordScreenBodyState();
}

class _PasswordScreenBodyState extends State<PasswordScreenBody> {
  bool _toggleShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: widget.passwordFormKey,
              child: TextFormField(
                controller: widget.passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder(
                        requiredMessage: "Please enter your password")
                    .minLength(6, 'Must contain at least 6 characters')
                    .build(),
                obscureText: _toggleShowPassword,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          widget.passwordController.clear();
                        },
                        icon: Image.asset("assets/images/clear.png")),
                    hintText: 'Minimum 6 characters',
                    hintStyle: const TextStyle(color: Color(0x66D1D1D1))),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  setState(() {
                    _toggleShowPassword = !_toggleShowPassword;
                  });
                },
                child: Text(
                  "${_toggleShowPassword ? 'Show' : 'Hide'} password",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.purple,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "By tapping Create Account, you agree to our Terms of Use and Privacy Policy",
              style: TextStyle(fontSize: 15, color: Color(0xFF989898)),
            ),
          ),
        )
      ],
    );
  }
}
