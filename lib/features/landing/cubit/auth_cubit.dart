import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/data/services/auth.dart' as authService;
import 'package:lets_play/main.dart';
import 'package:lets_play/models/user.dart';

import '../../../common/constants/constants.dart';
import '../../../common/constants/storage_contants.dart';
import '../../../data/core/errors/failures.dart';
import '../../home_screen/home_screen.dart';
import '../../profile/cubit/user_cubit.dart';
import '../models/registrationForm.dart';
import 'package:lets_play/data/services/userProfile.dart' as userProfileService;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.userCubit,
  }) : super(AuthInitial());
  final UserCubit userCubit;
  RegistrationForm _form = RegistrationForm();
  RegistrationForm get currentFormState => _form;

  Future login(String phone, String password) async {
    emit(AuthInitial());
    final Either<Failure, Map<String, dynamic>> response =
        await authService.login(phone: phone, password: password);

    response.fold((Failure failure) => emit(ErrorState(mapFailureToMessage(failure))),
        (Map<String, dynamic> map) async {
      final User user = formatUser(map['user']);
      userBox.put(StorageConstants.userToken, map['token']);
      userCubit.setProfile(isAuthed: true, user: user);
      await Future.wait([
        userCubit.getUserFavSports(),
        userCubit.getUserFavPlaygrounds(),
        userCubit.getUserSavedCards(),
        userCubit.getUserEngagementsDetails(),
      ]);

      emit(SuccessLoginState(user));
    });
  }

  Future generateOtp(String phone, String type, {bool resend = false}) async {
    emit(AuthInitial());
    try {
      final result = await authService.generateOtpNumber(phone: phone, type: type);
      _form = _form.copyWith(otp: result['otp'], phone: phone);
      emit(SuccessSentOtpState(result['otp']!, resend: resend));
    } catch (e) {
      if (e is DioError) {
        final int statusCode = e.response!.statusCode!;
        emit(ErrorState(statusCode == 401
            ? type == PASSWORD
                ? "There is no account with ths phone number"
                : 'An account with this number already exists'
            : 'Unexpected Error'));
      } else {
        emit(const ErrorState('Unexpected Error'));
      }
    }
  }

  setRegistrationForm({String? email, String? firstname, String? lastname, String? password}) {
    _form =
        _form.copyWith(email: email, firstname: firstname, lastname: lastname, password: password);
  }

  register() async {
    emit(AuthInitial());
    try {
      final result = await authService.register(
        phone: _form.phone!,
        password: _form.password!,
        email: _form.email!,
        firstname: _form.firstname!,
        lastname: _form.lastname!,
        otp: _form.otp!.toString(),
      );

      final User user = formatUser(result['user']);
      userBox.put(StorageConstants.userToken, result['token']);
      userCubit.setProfile(isAuthed: true, user: user);

      await Future.wait([
        userCubit.getUserFavSports(),
        userCubit.getUserFavPlaygrounds(),
        userCubit.getUserSavedCards(),
        userCubit.getUserEngagementsDetails(),
      ]);

      emit(const SuccessRegisterState());
    } catch (e) {
      if (e is DioError) {
        final int statusCode = e.response!.statusCode!;
        emit(ErrorState(
            statusCode == 422 ? 'An account with this email already exists' : 'Unexpected Error'));
      } else {
        emit(const ErrorState('Unexpected Error'));
      }
    }
  }

  Future updateUserFavCategories({required List<int> indexes, bool isUpdate = false}) async {
    emit(AuthInitial());
    try {
      await userProfileService.updateFavCategories(indexes: indexes);
      userCubit.getUserFavSports();
      if (isUpdate) homeCubit.getHomeDetails(userCubit);
      emit(const SuccessFavCategoriesUpdatedState());
    } catch (e) {
      emit(const ErrorState('Unexpected Error'));
    }
  }

  Future createNewPassword(
      {required String phone,
      required String otp,
      required String newPassword,
      required String newConfirmPassword}) async {
    emit(AuthInitial());
    try {
      final Either<Failure, Map<String, dynamic>> response = await authService.createNewPassword(
          phone: phone, newConfirmPassword: newConfirmPassword, newPassword: newPassword, otp: otp);
      response.fold((Failure failure) => emit(ErrorState(mapFailureToMessage(failure))),
          (Map<String, dynamic> map) async {
        await login(phone, newPassword);
        return emit(const SuccessCreatePasswordState());
      });
    } catch (e) {
      emit(const ErrorState('Unexpected Error'));
    }
  }
}
