enum PaymentMethod {
  creditCard,
  debitCard,
  googlePay,
  applePay,
  tokenization;

  String toDto() {
    switch (this) {
      case creditCard:
        return 'creditcard';
      case PaymentMethod.debitCard:
        return 'naps';
      case PaymentMethod.googlePay:
        return 'gPay';

      case PaymentMethod.applePay:
        return 'applePay';

      case PaymentMethod.tokenization:
        return 'creditcard';
    }
  }
}
