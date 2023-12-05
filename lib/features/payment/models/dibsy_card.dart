class DibsyCard {
  final String token;
  final String firstDigits;
  final String lastDigits;
  final String holderName;
  final String providerType;

  DibsyCard(
      {required this.firstDigits,
      required this.lastDigits,
      required this.holderName,
      required this.providerType,
      required this.token});
}

DibsyCard formatDibsyCard(map) {
  return DibsyCard(
    token: map['id'],
    firstDigits: map['cardBin'],
    lastDigits: map['cardLast4'],
    holderName: map['cardHolder'],
    providerType: map['cardScheme'],
  );
}
