import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/features/home_search/models/search_entity_type.dart';

import '../../main.dart';
import '../core/errors/failures.dart';

Future<Either<Failure, Map<String, dynamic>>> homeSearch({
  required String searchTerm,
  required List<int> categoriesIds,
  required SearchEntityType type,
  required double latitude,
  required double longitude,
}) async {
  try {
    Response response = await myDio.instance.post('home/search', data: {
      "search": searchTerm,
      "type": type.name,
      "categories": categoriesIds,
      'latitude': latitude,
      'longitude': longitude,
    });
    if (response.statusCode == 200) {
      return Right(response.data);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}
