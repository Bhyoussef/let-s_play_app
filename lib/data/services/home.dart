import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/models/sport_category_model.dart';
import '../../main.dart';

Future<Either<Failure, List<SportCategoryModel>>> listCategories() async {
  try {
    Response response = await myDio.instance.get('categories');

    if (response.statusCode == 200) {
      var items = List.from(response.data).map((e) => formatSportCategory(e)).toList();

      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, Map<String, dynamic>>> homeDetails({
  required double latitude,
  required double longitude,
}) async {
  try {
    Response response = await myDio.instance.post('home', queryParameters: {
      'latitude': latitude,
      'longitude': longitude,
    });

    if (response.statusCode == 200) {
      return Right(Map<String, dynamic>.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}
