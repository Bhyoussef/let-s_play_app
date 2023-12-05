enum PaymentModality {
  total,
  partial;

  @override
  String toString() => name.toLowerCase() == 'total' ? 'total' : 'partial';
}
