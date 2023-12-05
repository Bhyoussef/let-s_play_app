import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/models/sport_category_model.dart';

class PlaygroundModel {
  PlaygroundModel({
    required this.id,
    required this.category,
    required this.merchantId,
    required this.grassTypeEn,
    required this.grassTypeAr,
    required this.nameEn,
    required this.nameAr,
    required this.enDescription,
    required this.arDescription,
    required this.workingDays,
    required this.price,
    this.image,
    this.fullAddress,
    required this.buildingNo,
    required this.zoneNo,
    required this.streetNo,
    required this.latitude,
    required this.longitude,
    this.crFile,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.matchesCount,
    required this.isFav,
    required this.matches,
  });
  late final int id;
  late final SportCategoryModel? category;
  late final int? merchantId;
  late final String? nameEn;
  late final String? nameAr;
  late final String? grassTypeEn;
  late final String? grassTypeAr;
  late final String? enDescription;
  late final String? arDescription;
  late final String? workingDays;
  late final num? price;
  late final double? fromUserDistance;
  late final String? image;
  late final String? fullAddress;
  late final String? buildingNo;
  late final String? zoneNo;
  late final String? streetNo;
  late final double? latitude;
  late final double? longitude;
  late final String? crFile;
  late final bool? status;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? matchesCount;
  late final String? phone;
  late final bool? isFav;
  late final List<MatchModel>? matches;
  late final List<TagModel>? tags;
  late final List<WorkingShiftModel>? shifts;

  PlaygroundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category =
        json['category'] != null ? formatSportCategory(json['category']) : null;
    merchantId = json['merchant_id'];
    nameEn = json['en_name'];
    nameAr = json['ar_name'];
    grassTypeEn =
        json['grass_type'] != null ? json['grass_type']['name_en'] : null;
    grassTypeAr =
        json['grass_type'] != null ? json['grass_type']['name_ar'] : null;
    enDescription = json['en_description'];
    arDescription = json['ar_description'];
    workingDays = json['working_days'];
    price = json['price'];
    image = json['main_image'];
    fullAddress = json['full_address'];
    buildingNo = json['building_no'];
    zoneNo = json['zone_no'];
    streetNo = json['street_no'];
    latitude = double.tryParse(json['latitude'].toString());
    longitude = double.tryParse(json['longitude'].toString());
    phone = json['phone'];
    crFile = json['crFile'];
    status = json['status'] == 1;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    matchesCount = json['matches_count'];
    isFav = json['isFavorite'] ?? false;
    fromUserDistance = json['distance'];
    matches = List.from(json['matches'] ?? []).map(formatMatchModel).toList();
    tags = List.from(json['tags'] ?? []).map(formatPgTagModel).toList();
    shifts =
        List.from(json['open_hours'] ?? []).map(formatPgShiftModel).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category'] = category;
    _data['merchant_id'] = merchantId;
    _data['en_name'] = nameEn;
    _data['ar_name'] = nameAr;
    _data['grass_type_en'] = grassTypeEn;
    _data['grass_type_ar'] = grassTypeAr;
    _data['en_description'] = enDescription;
    _data['ar_description'] = arDescription;
    _data['working_days'] = workingDays;
    _data['price'] = price;
    _data['main_image'] = image;
    _data['full_address'] = fullAddress;
    _data['building_no'] = buildingNo;
    _data['zone_no'] = zoneNo;
    _data['street_no'] = streetNo;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['cr_file'] = crFile;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['matches_count'] = matchesCount;
    return _data;
  }
}

class TagModel {
  final int id;
  final String? nameEn;
  final String? nameAr;

  TagModel({required this.id, required this.nameEn, required this.nameAr});
}

TagModel formatPgTagModel(map) {
  return TagModel(
    id: map['id'],
    nameEn: map['name_en'] ?? "",
    nameAr: map['name_ar'] ?? "",
  );
}

class WorkingShiftModel {
  final int shiftNb;
  final String? openAt;
  final String? closeAt;

  WorkingShiftModel(
      {required this.shiftNb, required this.openAt, required this.closeAt});
}

WorkingShiftModel formatPgShiftModel(map) {
  return WorkingShiftModel(
    shiftNb: map['shift'],
    openAt: map['open_at'] ?? "",
    closeAt: map['close_at'] ?? "",
  );
}
