import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/models/server/playground_model.dart';
import '../../main.dart';

Future<Either<Failure, List<PlaygroundModel>>> listPlaygrounds({
  required int categoryId,
  required String type,
  required double latitude,
  required double longitude,
}) async {
  try {
    Response response =
        await myDio.instance.post('playgrounds/category', queryParameters: {
      'category_id': categoryId,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
    });

    if (response.statusCode == 200) {
      var items = List.from(response.data)
          .map((e) => PlaygroundModel.fromJson(e))
          .toList();

      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, PlaygroundModel>> playgroundDetails({
  required int playgroundId,
  required String type,
  required double latitude,
  required double longitude,
}) async {
  try {
    Response response = await myDio.instance
        .post('playgrounds/details/$playgroundId', queryParameters: {
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
    });

    if (response.statusCode == 200) {
      var pg = PlaygroundModel.fromJson(response.data);

      return Right(pg);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}

Future<Map<String, dynamic>> setFavourite(
    {required int playgroundId, required bool isFaved}) async {
  Response response =
      await myDio.instance.put('/playgrounds/favorite/$playgroundId', data: {
    "favorite": isFaved,
  });
  Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
  return data;
}
