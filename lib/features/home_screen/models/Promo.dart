class HomePromo {
  final int? id;
  final int? value;
  final String? image;

  const HomePromo({required this.id, required this.value, required this.image});
}

HomePromo formatHomePromo(map) {
  return HomePromo(
    id: map['id'],
    value: map['promo'],
    image: map['image'],
  );
}
