import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import '../../features/my_booking_screen/models/booking_model.dart';
import '../../main.dart';

Future<Either<Failure, List<BookingModel>>> getBooking({required String type}) async {
  try {
    Response response = await myDio.instance.get('booking/$type');

    if (response.statusCode == 200) {
      var items = List.from(response.data).map((e) => BookingModel.fromJson(e) ).toList();
      return Right(items);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    print('error parsing : $e');
    return Left(ServerFailure());
  }
}
