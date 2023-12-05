class CoachingModel {
  CoachingModel({
    required this.id,
    required this.name,
    required this.date,
    required this.photo,
    required this.price,
    required this.address,
  });
  late final int id;
  late final String name;
  late final String date;
  late final String photo;
  late final double price;
  late final String address;

  CoachingModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    date = json['date'];
    price = json['price'];
    photo = json['photo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['date'] = date;
    _data['price'] = price;
    _data['photo'] = photo;
    _data['address'] = address;
    return _data;
  }
}