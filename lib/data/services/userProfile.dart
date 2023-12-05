import 'dart:async';

import 'package:dio/dio.dart';

import '../../main.dart';
import 'package:http_parser/src/media_type.dart';

Future<Map<String, dynamic>> fetchProfile() async {
  Response response = await myDio.instance.get('user');
  return Map<String, dynamic>.from(response.data);
}

Future<List> fetchUserFavSports() async {
  Response response = await myDio.instance.get('user/favorite_categories');
  return List.from(response.data['data']);
}

Future<Map<String, dynamic>> updateFavCategories({required List<int> indexes}) async {
  final Map<String, dynamic> favs = {};
  for (int i = 0; i < indexes.length; i++) {
    favs['favorites[$i]'] = indexes[i];
  }

  Response response = await myDio.instance.put(
    'user/favorite_categories/update',
    queryParameters: favs,
  );
  return Map<String, dynamic>.from(response.data);
}

Future<Map<String, dynamic>> changeProfileAvatar({
  required String pickedAvatarPath,
}) async {
  String? fileType;
  fileType = pickedAvatarPath.split('.').last;

  final FormData formData = FormData.fromMap({
    "avatar": await MultipartFile.fromFile(pickedAvatarPath,
        filename: "userAvatar.$fileType", contentType: MediaType('image', fileType)),
  });
  final response = await myDio.instance.post('user/picture/update', data: formData);
  return Map<String, dynamic>.from(response.data);
}

Future<Map<String, dynamic>> editProfile({
  required String firstname,
  required String lastname,
  required String email,
  required String gender,
}) async {
  final response = await myDio.instance.post('user/info/update', data: {
    "email": email.toLowerCase(),
    "first_name": firstname,
    "last_name": lastname,
    "gender": gender,
  });
  return Map<String, dynamic>.from(response.data);
}

Future<Map<String, dynamic>> changePassword({
  required String currentPw,
  required String newPw,
}) async {
  final response = await myDio.instance.post('user/password/update', data: {
    "current_password": currentPw,
    "new_password": newPw,
  });
  return Map<String, dynamic>.from(response.data);
}

Future<List> fetchUserFavPlaygrounds() async {
  Response response = await myDio.instance.get('playgrounds/favorite');
  return List.from(response.data);
}

Future<Map<String, dynamic>> fetchUserEngagementCounts() async {
  Response response = await myDio.instance.get('user/counts');
  return Map<String, dynamic>.from(response.data);
}

Future<List> fetchUserSportsEngaged() async {
  Response response = await myDio.instance.get('user/sports');
  return List.from(response.data['sports']['data']);
}

Future<List> fetchUserClubsList() async {
  Response response = await myDio.instance.get('user/clubs');
  return List.from(response.data['clubs']['data']);
}

Future<List> fetchUserFrequentPlayersList() async {
  Response response = await myDio.instance.get('user/frequent_players');
  return List.from(response.data['frequent_players']);
}
