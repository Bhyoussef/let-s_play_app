import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/features/payment/models/dibsy_card.dart';
import 'package:lets_play/features/payment/models/payment_response.dart';
import '../../main.dart';
import '../core/errors/failures.dart';

Future<Either<Failure, PaymentResponseModel>> makePayment(
    {required Map<String, dynamic> params}) async {
  try {
    Response response = await myDio.instance.post('/dibsy/pay', data: params);

    if (response.statusCode == 200) {
      var map = Map<String, dynamic>.from(response.data);
      return Right(formatPaymentResponseModel(map));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<DibsyCard>>> getUserPaymentCards() async {
  try {
    Response response = await myDio.instance.get(
      '/dibsy/customer/card',
    );

    if (response.statusCode == 200) {
      var cards =
          List.from(response.data).map((e) => formatDibsyCard(e)).toList();

      return Right(cards);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, List<DibsyCard>>> deleteUserSavedCard(
    String cardToken) async {
  try {
    Response response = await myDio.instance.post(
      '/dibsy/customer/card/delete',
      data: {'card_token': cardToken},
    );

    if (response.statusCode == 200) {
      var cards =
          List.from(response.data).map((e) => formatDibsyCard(e)).toList();

      return Right(cards);
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}
