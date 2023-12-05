import 'enums/sport_type.dart';

class SportCategoryModel {
  const SportCategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.sportType,
  });
  final int id;
  final String? nameEn;
  final String? nameAr;
  final String? icon;
  final SportType sportType;
}

SportCategoryModel formatSportCategory(map) {
  return SportCategoryModel(
      id: map['id'],
      nameEn: map['en_name'],
      nameAr: map['ar_name'],
      icon: map['icon'],
      sportType: getSportTypeFromEnName(map['en_name']));
}

SportType getSportTypeFromEnName(String? name) {
  switch (name.toString().toLowerCase()) {
    case 'football':
      return SportType.football;
    case 'basketball':
      return SportType.basketball;
    case 'volleyball':
      return SportType.volleyball;
    case 'tennis':
      return SportType.tennis;
    case 'squash':
      return SportType.squash;
    case 'padel':
      return SportType.padel;
    case 'padbol':
      return SportType.padbol;
    case 'badminton':
      return SportType.badminton;
  }
  return SportType.football;
}
