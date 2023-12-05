import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  isValidEmail() => add((value) {
        if (value == null || value.isEmpty) return 'cant be empty';
        final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        return !emailRegExp.hasMatch(value) ? 'Invalid email' : null;
      });
}
