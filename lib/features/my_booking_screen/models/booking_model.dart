class BookingModel {
  BookingModel({
    required this.id,
    required this.category,
    required this.enName,
    required this.arName,
    required this.fullAddress,
    required this.startDate,
    required this.endDate,
    required this.maxPlayer,
    required this.count,
    required this.expirationTime,
    required this.duration,
    required this.latitude,
    required this.longitude,
  });
  late final int id;
  late final Category category;
  late final String? enName;
  late final String? arName;
  late final String? fullAddress;
  late final String? startDate;
  late final String? endDate;
  late final int? maxPlayer;
  late final int? count;
  late final String? expirationTime;
  late final int? duration;
  late final double? latitude;
  late final double? longitude;

  BookingModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    category = Category.fromJson(json['category']);
    enName = json['en_name'];
    arName = json['ar_name'];
    fullAddress = json['full_address'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    maxPlayer = json['max_player'];
    count = json['count'];
    expirationTime = json['expiration_time'];
    duration = json['duration'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category'] = category.toJson();
    _data['en_name'] = enName;
    _data['ar_name'] = arName;
    _data['full_address'] = fullAddress;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['max_player'] = maxPlayer;
    _data['count'] = count;
    _data['expiration_time'] = expirationTime;
    _data['duration'] = duration;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.arName,
    required this.enName,
    required this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String arName;
  late final String enName;
  late final String icon;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ar_name'] = arName;
    _data['en_name'] = enName;
    _data['icon'] = icon;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}