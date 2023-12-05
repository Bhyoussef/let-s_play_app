import 'package:lets_play/features/payment/models/dibsy_card.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/models/server/playground_model.dart';
import 'package:lets_play/models/sport_category_model.dart';

class UserEngagementCounts {
  final int? matchesCount;
  final int? friendsCount;
  final List<MatchModel>? joinedMatches;
  final List<MatchModel>? createdMatches;

  UserEngagementCounts(
      {this.matchesCount, this.friendsCount, this.joinedMatches, this.createdMatches});
}

class User {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? gender;
  final List<SportCategoryModel>? favoriteSportCategories;
  final List<PlaygroundModel>? favoritePlaygrounds;
  final List<DibsyCard>? savedCards;
  final UserEngagementCounts? userEngagementCounts;
  final List<PlayerModel>? frequentPlayers;
  final List<PlaygroundModel>? clubs;
  final List<SportCategoryModel>? sportsPlayed;
  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.avatar,
    this.gender,
    this.favoriteSportCategories,
    this.favoritePlaygrounds,
    this.savedCards,
    this.userEngagementCounts,
    this.frequentPlayers,
    this.clubs,
    this.sportsPlayed,
  });
  User copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? gender,
    List<SportCategoryModel>? favoriteSportCategories,
    List<PlaygroundModel>? favoritePlaygrounds,
    List<DibsyCard>? savedCards,
    String? avatar,
    UserEngagementCounts? userEngagementCounts,
    List<PlayerModel>? frequentPlayers,
    List<PlaygroundModel>? clubs,
    List<SportCategoryModel>? sportsPlayed,
  }) {
    return User(
      id: id,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      favoriteSportCategories: favoriteSportCategories ?? this.favoriteSportCategories,
      favoritePlaygrounds: favoritePlaygrounds ?? this.favoritePlaygrounds ?? [],
      userEngagementCounts: userEngagementCounts ?? this.userEngagementCounts,
      savedCards: savedCards ?? this.savedCards ?? [],
      frequentPlayers: frequentPlayers ?? this.frequentPlayers ?? [],
      clubs: clubs ?? this.clubs ?? [],
      sportsPlayed: sportsPlayed ?? this.sportsPlayed ?? [],
    );
  }
}

User formatUser(map) {
  return User(
    id: map['id'],
    email: map['email'],
    firstname: map['first_name'],
    lastname: map['last_name'],
    phone: map['phone'],
    avatar: map['avatar'],
    gender: map['gender'],
  );
}
