import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/features/register/mixin/register_flow_mixin.dart';

class NameScreenBody extends RegisterFlowBody {
  const NameScreenBody(
      {required this.lastnameController,
      required this.firstnameController,
      required this.nameFormKey,
      Key? key,
      required RegisterFlowStepMixin registerFlowMixin})
      : super(key: key, registerFlowMixin: registerFlowMixin);
  final TextEditingController lastnameController;
  final TextEditingController firstnameController;
  final GlobalKey<FormState> nameFormKey;
  @override
  State<NameScreenBody> createState() => _NameScreenBodyState();
}

class _NameScreenBodyState extends State<NameScreenBody> {
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
              child: Form(
                key: widget.nameFormKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: TextFormField(
                      controller: widget.firstnameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidationBuilder(
                              requiredMessage: "First name is required")
                          .minLength(3)
                          .build(),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'First name',
                          hintStyle: TextStyle(color: Color(0x66D1D1D1))),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                        child: TextFormField(
                      controller: widget.lastnameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ValidationBuilder(
                              requiredMessage: "Last name is required")
                          .minLength(3)
                          .build(),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Last name',
                          hintStyle: TextStyle(color: Color(0x66D1D1D1))),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
            )
          ],
        ))
      ],
    );
  }
}
