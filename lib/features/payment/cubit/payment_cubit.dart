import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:lets_play/data/core/errors/failures.dart';
import 'package:lets_play/features/payment/models/payment_method.dart';
import 'package:lets_play/features/payment/models/payment_response.dart';
import 'package:lets_play/features/payment/models/payment_sequence.dart';
import 'package:lets_play/features/payment/models/payment_type.dart';
import 'package:meta/meta.dart';
import 'package:lets_play/data/services/payment.dart' as paymentService;
import 'package:pay/pay.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  creditCardTokenSucceded(
      {required String token, required SequenceType sequenceType}) {
    emit(CreditCardTokenSuccess(token: token, sequenceType: sequenceType));
  }

  paymentRequested({
    String? methodToken,
    required PaymentMethod paymentMethod,
    PaymentType paymentType = PaymentType.cart,
    SequenceType sequenceType = SequenceType.oneOff,
    int? matchId,
  }) async {
    emit(PaymentLoading());

    Map<String, dynamic> params = {
      "payment_type": paymentType.toDto(),
      "payment_method": paymentMethod.toDto(),
      if (methodToken != null) "cardToken": methodToken,
      "sequenceType": sequenceType.toDto(),
      if (matchId != null) "match_Id": matchId
    };
    final Either<Failure, PaymentResponseModel> response =
        await paymentService.makePayment(params: params);

    response.fold((l) {
      emit(PaymentRespondedWithFailure(
          'Payment gateway responded with failure'));
    }, (result) {
      if (result.success) {
        if (result.shouldWebview) {
          emit(PaymentRespondedWithSuccess(
              shouldWebview: true, webViewUrl: result.redirectUrl));
        } else {
          emit(PaymentRespondedWithSuccess(shouldWebview: false));
        }
      } else {
        emit(PaymentRespondedWithFailure(
            'Payment gateway responded with failure'));
      }
    });
  }

  onNativePayPressed(
      {required num price, required PayProvider provider}) async {
    final _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: price.toStringAsFixed(2),
        status: PaymentItemStatus.final_price,
      )
    ];
    Pay _payClient = Pay.withAssets([
      'default_payment_profile_apple_pay.json',
      'default_payment_profile_google_pay.json'
    ]);
    // final result = await _payClient.showPaymentSelector(
    //   provider: provider,
    //   paymentItems: _paymentItems,
    // );
    final userCanPay = await _payClient.userCanPay(provider);
    print('userCanPay= $userCanPay');
    // emit(NativePayTokenSuccess(
    //     token: 'token', isGoogle: provider == PayProvider.google_pay));
  }
}
