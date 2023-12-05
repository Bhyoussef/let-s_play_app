class PaymentResponseModel {
  final bool success;
  final bool shouldWebview;
  final String? redirectUrl;
  final String dibsySatus;
  final String message;

  PaymentResponseModel(
      {required this.success,
      required this.shouldWebview,
      this.redirectUrl,
      required this.dibsySatus,
      required this.message});
}

PaymentResponseModel formatPaymentResponseModel(map) {
  return PaymentResponseModel(
    success: map['result'],
    shouldWebview: map['url'] != null && map['url'].toString().isNotEmpty,
    dibsySatus: map['dibsy_status'],
    message: map['message'],
    redirectUrl: map['url'],
  );
}
