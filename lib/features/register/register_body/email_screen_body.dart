import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/common/extensions/validationBuilder.dart';
import 'package:lets_play/features/landing/login_screen.dart';
import 'package:lets_play/features/register/mixin/register_flow_mixin.dart';

class EmailScreenBody extends RegisterFlowBody {
  const EmailScreenBody({
    Key? key,
    required RegisterFlowStepMixin registerFlowMixin,
    required this.emailFormKey,
    required this.emailController,
  }) : super(key: key, registerFlowMixin: registerFlowMixin);
  final GlobalKey<FormState> emailFormKey;
  final TextEditingController emailController;
  @override
  State<EmailScreenBody> createState() => _EmailScreenBodyState();
}

class _EmailScreenBodyState extends State<EmailScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/envelop.png",
                        width: 32,
                        fit: BoxFit.fitWidth,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Flexible(
                      child: Form(
                    key: widget.emailFormKey,
                    child: TextFormField(
                      controller: widget.emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidationBuilder(
                              requiredMessage: "Please enter your email")
                          .isValidEmail()
                          .build(),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'name@example.com',
                          hintStyle: TextStyle(color: Color(0x66D1D1D1))),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
            const Expanded(
              child: SocialMediaWidget(
                dark: true,
              ),
            )
          ],
        ))
      ],
    );
  }
}
