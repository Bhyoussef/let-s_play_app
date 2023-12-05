import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import '../register/mixin/register_flow_mixin.dart';

class NewPasswordScreen extends RegisterFlowBody {
  const NewPasswordScreen({
    Key? key,
    required RegisterFlowStepMixin registerFlowMixin,
    required this.passwordFormKey,
    required this.passwordController,
    required this.retypePasswordController,
  }) : super(key: key, registerFlowMixin: registerFlowMixin);
  final GlobalKey<FormState> passwordFormKey;
  final TextEditingController passwordController;
  final TextEditingController retypePasswordController;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: widget.passwordFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder(
                    requiredMessage: "Please enter your password")
                    .minLength(6, 'Must contain at least 6 characters')
                    .build(),
                obscureText: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter new password',
                    hintStyle: TextStyle(color: Color(0x66D1D1D1))),
                style:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.retypePasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder(
                    requiredMessage: "Please enter your password")
                    .minLength(6, 'Must contain at least 6 characters')
                    .build(),
                obscureText: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Retype new password',
                    hintStyle: TextStyle(color: Color(0x66D1D1D1))),
                style:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
