import 'package:flutter/material.dart';

mixin RegisterFlowStepMixin {
  void canProceedToNextStep();
}

abstract class RegisterFlowBody extends StatefulWidget {
  final RegisterFlowStepMixin registerFlowMixin;

  const RegisterFlowBody({Key? key, required this.registerFlowMixin})
      : super(key: key);
}
