part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class CreditCardTokenSuccess extends PaymentState {
  final String token;
  final SequenceType sequenceType;

  CreditCardTokenSuccess({required this.token, required this.sequenceType});
}

class PaymentRespondedWithSuccess extends PaymentState {
  final bool shouldWebview;
  final String? webViewUrl;

  PaymentRespondedWithSuccess({required this.shouldWebview, this.webViewUrl});
}

class PaymentRespondedWithFailure extends PaymentState {
  final String message;

  PaymentRespondedWithFailure(this.message);
}

class NativePayTokenSuccess extends PaymentState {
  final String token;
  final bool isGoogle;

  NativePayTokenSuccess({required this.token, required this.isGoogle});
}
