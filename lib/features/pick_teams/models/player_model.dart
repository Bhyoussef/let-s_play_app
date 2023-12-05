import 'package:lets_play/models/user.dart';

class PlayerModel {
  PlayerModel({
    this.roomId,
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.gender,
    this.emailVerifiedAt,
    this.banned,
    this.createdAt,
    this.updatedAt,
    this.isMe = false,
    this.isConfirmed,
    required this.fieldPosition,
  });
  final int id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? gender;
  final String? emailVerifiedAt;
  final int? banned;
  final String? createdAt;
  final String? updatedAt;
  final bool isMe;
  final bool? isConfirmed;
  final int? fieldPosition;
  final int? roomId; // for Chat

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['avatar'] = avatar;
    _data['gender'] = gender;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['banned'] = banned;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

PlayerModel playerFromUser({required User user, required int fieldPosition, isConfirmed = false}) {
  return PlayerModel(
    id: user.id!,
    firstName: user.firstname!,
    lastName: user.lastname!,
    email: user.email!,
    phone: user.phone!,
    gender: user.gender,
    avatar: user.avatar,
    banned: 0,
    isMe: true,
    isConfirmed: isConfirmed,
    fieldPosition: fieldPosition,
  );
}

PlayerModel formatPlayer(json) {
  return PlayerModel(
    id: json['id'],
    roomId: json['room_id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    phone: json['phone'],
    avatar: json['avatar'],
    gender: json['gender'],
    emailVerifiedAt: json['email_verified_at'],
    banned: json['banned'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    isMe: false,
    fieldPosition: json['fieldPosition'],
  );
}

PlayerModel formatPlayerFromParticipantJson(Map<String, dynamic> json) {
  return PlayerModel(
    id: json['user']['id'],
    firstName: json['user']['first_name'],
    lastName: json['user']['last_name'],
    avatar: json['user']['avatar'],
    isMe: false,
    isConfirmed: json['status'].toString().toLowerCase() == 'paid',
    fieldPosition: int.parse(json['position'].toString()),
  );
}
