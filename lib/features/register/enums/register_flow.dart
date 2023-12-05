enum RegisterFlow { phone, otp, email, name, password }

extension SubmitButtonTextExtenstion on RegisterFlow {
  String get submitButtonText {
    switch (this) {
      case RegisterFlow.otp:
        return 'Verify';
      case RegisterFlow.password:
        return 'Create account';
      default:
        return 'Next';
    }
  }
}

extension RegisterFlowStepGroup on RegisterFlow {
  int get stepGroup {
    switch (this) {
      case RegisterFlow.name:
        return 1;
      case RegisterFlow.password:
        return 2;
      default:
        return -1;
    }
  }
}

extension RegisterFlowSteps on RegisterFlow {
  bool get needStepProgress {
    switch (this) {
      case RegisterFlow.name:
      case RegisterFlow.password:
        return true;
      default:
        return false;
    }
  }
}

enum ForgotPSWDFlow { phone, otp, password }
extension SubmitBottomButtonTextExtenstion on ForgotPSWDFlow {
  String get submitButtonText {
    switch (this) {
      case ForgotPSWDFlow.otp:
        return 'Verify';
      case ForgotPSWDFlow.password:
        return 'Change password';
      default:
        return 'Next';
    }
  }
}