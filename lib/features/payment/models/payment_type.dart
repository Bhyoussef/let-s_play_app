enum PaymentType {
  cart,
  wallet;

  String toDto() {
    switch (this) {
      case cart:
        return 'cart_payment';
      case wallet:
        return 'wallet_payment';
    }
  }
}
