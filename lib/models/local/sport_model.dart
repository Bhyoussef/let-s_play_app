class SportFieldModel {
  SportFieldModel({
    required this.id,
    required this.title,
    required this.city,
    required this.distance,
    required this.image,
    required this.grassType,
    required this.nbAvailableCourt,
    required this.womenOnly,
    required this.price,
    required this.liked,
  });
  late final int id;
  late final String title;
  late final String city;
  late final int distance;
  late final String image;
  late final String grassType;
  late final int nbAvailableCourt;
  late final bool womenOnly;
  late final String price;
  late final bool liked;

  SportFieldModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    city = json['city'];
    distance = json['distance'];
    image = json['image'];
    grassType = json['grass_type'];
    nbAvailableCourt = json['nb_available_court'];
    womenOnly = json['women_only'];
    price = json['price'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['city'] = city;
    _data['distance'] = distance;
    _data['image'] = image;
    _data['grass_type'] = grassType;
    _data['nb_available_court'] = nbAvailableCourt;
    _data['women_only'] = womenOnly;
    _data['price'] = price;
    _data['liked'] = liked;
    return _data;
  }

}