import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lets_play/data/core/appEnv.dart';
import 'package:lets_play/data/core/errors/failures.dart';

import '../../main.dart';

Future<bool> checkAccessTokenValidity() async {
  try {
    await myDio.instance.get(
      'verifyToken',
    );
    return true;
  } catch (e) {
    return false;
  }
}


Future<Map<String, dynamic>> generateOtpNumber(
    {required String phone, required String type}) async {
  Response response = await myDio.instance.post(
    'sendotp',
    data: {"phone": AppEnvState.mobilePrefix + phone, "type": type},
  );
  return Map<String, dynamic>.from(response.data);
}

Future<Either<Failure, Map<String, dynamic>>> login(
    {required String phone, required String password}) async {
  try {
    Response response = await myDio.instance.post(
      'signin',
      data: {
        "phone": AppEnvState.mobilePrefix + phone,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return Right(Map<String, dynamic>.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}

Future<Map<String, dynamic>> register({
  required String firstname,
  required String lastname,
  required String otp,
  required String phone,
  required String email,
  required String password,
}) async {
  Response response = await myDio.instance.post(
    'signup',
    data: {
      "first_name": firstname,
      "last_name": lastname,
      "phone": AppEnvState.mobilePrefix + phone,
      "otp": otp,
      "email": email,
      "password": password,
      "gender": "male",
    },
  );
  return Map<String, dynamic>.from(response.data);
}

Future<Map<String, dynamic>> forgotPassword({
  required String otp,
  required String phone,
  required String newPassword,
}) async {
  Response response = await myDio.instance.post(
    'forgot-password',
    data: {
      "phone": phone,
      "otp": otp,
      "new_password": newPassword,
      "new_confirm_password": newPassword,
    },
  );
  return Map<String, dynamic>.from(response.data);
}

Future<Map<String, dynamic>> logout() async {
  Response response = await myDio.instance.post(
    'logout',
  );
  return Map<String, dynamic>.from(response.data);
}


Future<Either<Failure, Map<String, dynamic>>> createNewPassword(
    {required String phone, required String otp, required String newPassword, required String newConfirmPassword}) async {
  try {
    Response response = await myDio.instance.post(
      'forgot-password',
      data: {"phone": AppEnvState.mobilePrefix + phone,
        "otp": otp,
        "new_password": newPassword,
        "new_confirm_password": newConfirmPassword},
    );

    if (response.statusCode == 200) {
      return Right(Map<String, dynamic>.from(response.data));
    } else {
      return Left(ServerFailure());
    }
  } catch (e) {
    return Left(ServerFailure());
  }
}
