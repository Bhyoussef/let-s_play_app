import 'dart:async';

import 'package:dio/dio.dart';

import '../../main.dart';

Future<List> fetchSportCategoriesToFav() async {
  Response response = await myDio.instance.get('categories');
  return List.from(response.data);
}
