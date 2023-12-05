class RegistrationForm {
  final int? otp;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final String? password;

  RegistrationForm(
      {this.otp,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.password});

  RegistrationForm copyWith({
    int? otp,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? password,
  }) {
    return RegistrationForm(
      otp: otp ?? this.otp,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      password: password ?? this.password,
    );
  }
}
