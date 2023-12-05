class SettingsModel {
  SettingsModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.numberPlayers,
    required this.durations,
  });
  late final int id;
  late final String arName;
  late final String enName;
  late final String icon;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final List<NumberPlayers> numberPlayers;
  late final List<Durations> durations;

  SettingsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    numberPlayers = List.from(json['number_players']).map((e)=>NumberPlayers.fromJson(e)).toList();
    durations = List.from(json['durations']).map((e)=>Durations.fromJson(e)).toList();
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
    _data['number_players'] = numberPlayers.map((e)=>e.toJson()).toList();
    _data['durations'] = durations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class NumberPlayers {
  NumberPlayers({
    required this.id,
    required this.categoryId,
    required this.playersCount,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final int categoryId;
  late final int playersCount;
  late final Null createdAt;
  late final Null updatedAt;

  NumberPlayers.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['category_id'];
    playersCount = json['players_count'];
    createdAt = null;
    updatedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['players_count'] = playersCount;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Durations {
  Durations({
    required this.id,
    required this.categoryId,
    required this.duration,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final int categoryId;
  late final int duration;
  late final Null createdAt;
  late final Null updatedAt;

  Durations.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['category_id'];
    duration = json['duration'];
    createdAt = null;
    updatedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['duration'] = duration;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}