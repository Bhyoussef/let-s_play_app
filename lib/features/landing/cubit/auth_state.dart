part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class SuccessLoginState extends AuthState {
  const SuccessLoginState(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class SuccessRegisterState extends AuthState {
  const SuccessRegisterState();

  @override
  List<Object> get props => [];
}

class SuccessFavCategoriesUpdatedState extends AuthState {
  const SuccessFavCategoriesUpdatedState();

  @override
  List<Object> get props => [];
}


class SuccessCreatePasswordState extends AuthState {
  const SuccessCreatePasswordState();

  @override
  List<Object> get props => [];
}

class SuccessSentOtpState extends AuthState {
  const SuccessSentOtpState(this.otp, {this.resend = false});

  final int otp;
  final bool resend;

  @override
  List<Object> get props => [otp, resend];
}

class ErrorState extends AuthState {
  const ErrorState(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
