import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lets_play/common/components/yellow_submit_button.dart';
import 'package:lets_play/features/payment/cubit/payment_cubit.dart';
import 'package:lets_play/features/payment/models/payment_sequence.dart';
import 'package:lets_play/routes/routes_list.dart';
import 'package:pay/pay.dart';

import '../../common/components/standard_close_appBar.dart';
import '../../common/constants/app_constants.dart';
import 'models/payment_method.dart';
import 'widgets/CouponTextField.dart';
import 'sections/PayWithSection.dart';

class MatchPaymentScreen extends StatelessWidget {
  const MatchPaymentScreen(
      {Key? key, required this.amount, required this.matchId})
      : super(key: key);
  final num amount;
  final int matchId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: MatchPaymentContent(
        amount: amount,
        matchId: matchId,
      ),
    );
  }
}

class MatchPaymentContent extends StatefulWidget {
  const MatchPaymentContent({
    Key? key,
    required this.amount,
    required this.matchId,
  }) : super(key: key);

  final num amount;
  final int matchId;

  @override
  State<MatchPaymentContent> createState() => _MatchPaymentContentState();
}

class _MatchPaymentContentState extends State<MatchPaymentContent> {
  PaymentMethod? currentMethod;
  String? selectedCardToken;
  @override
  Widget build(BuildContext context) {
    final paymentCubit = context.read<PaymentCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildStandardCloseAppBar(context: context, title: 'Checkout'),
      bottomNavigationBar: PayButton(
          price: widget.amount,
          matchId: widget.matchId,
          currentMethod: currentMethod,
          paymentCubit: paymentCubit,
          selectedCardToken: selectedCardToken),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentLoading) {
            EasyLoading.show();
          }
          if (state is CreditCardTokenSuccess) {
            paymentCubit.paymentRequested(
                paymentMethod: PaymentMethod.creditCard,
                methodToken: state.token,
                sequenceType: state.sequenceType,
                matchId: widget.matchId);
          }
          if (state is NativePayTokenSuccess) {
            paymentCubit.paymentRequested(
                paymentMethod: state.isGoogle
                    ? PaymentMethod.googlePay
                    : PaymentMethod.applePay,
                methodToken: state.token,
                matchId: widget.matchId);
          }
          if (state is PaymentRespondedWithFailure) {
            EasyLoading.dismiss();

            EasyLoading.showError(state.message);
          }
          if (state is PaymentRespondedWithSuccess) {
            EasyLoading.dismiss();
            if (state.shouldWebview) {
              // webview
              Navigator.pushNamed(context, RouteList.webviewPaymentScreen,
                  arguments: {'checkoutUrl': state.webViewUrl!}).then((value) {
                if (value == false) {
                  EasyLoading.showError("Payment Failed, please try again...");
                }
              });
            } else {
              if (currentMethod == PaymentMethod.tokenization) {
                Navigator.pushNamed(context, RouteList.successPaymentScreen);
              } else {
                EasyLoading.showSuccess("Payment Succeeded");
              }
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 20),
                            Text('Do You Have a Promo Code?',
                                style: AppStyles.inter17Bold),
                            SizedBox(height: 7),
                            CouponTextField(),
                            SizedBox(height: 22),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: AppColors.backGrey,
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Payment method',
                            style: AppStyles.inter17Bold),
                      ),
                      PayWithSection(
                        paymentMethodCallback: (method) {
                          currentMethod = method;
                          setState(() {});
                        },
                        tokenizationCardTokenCallback: (savedCardToken) {
                          selectedCardToken = savedCardToken;
                          setState(() {});
                        },
                      ),
                    ]),
              ),

              //Total
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: AppStyles.inter17Bold),
                      Text(
                        'QAR ${widget.amount.toStringAsFixed(2)}',
                        style: AppStyles.inter20SemiBold
                            .copyWith(color: AppColors.purple),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({
    Key? key,
    required this.currentMethod,
    required this.paymentCubit,
    required this.selectedCardToken,
    required this.matchId,
    required this.price,
  }) : super(key: key);

  final PaymentMethod? currentMethod;
  final PaymentCubit paymentCubit;
  final String? selectedCardToken;
  final int matchId;
  final num price;
  @override
  Widget build(BuildContext context) {
    final _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: price.toStringAsFixed(2),
        status: PaymentItemStatus.final_price,
      )
    ];
    return SizedBox(
      height: 75,
      width: 30,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child:
            // currentMethod == PaymentMethod.googlePay
            false
                ? GooglePayButton(
                    paymentConfigurationAsset:
                        'default_payment_profile_google_pay.json',
                    paymentItems: _paymentItems,
                    height: 75,
                    onError: (error) {
                      inspect(error);
                    },
                    childOnError: const Text('Button Error'),
                    type: GooglePayButtonType.buy,
                    margin: const EdgeInsets.only(top: 15.0),
                    onPaymentResult: (result) {},
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                :
                // currentMethod == PaymentMethod.applePay
                false
                    ? ApplePayButton(
                        paymentConfigurationAsset:
                            'default_payment_profile_apple_pay.json',
                        paymentItems: _paymentItems,
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result) {},
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : YellowSubmitButton(
                        buttonText: 'Proceed to payment',
                        height: 75,
                        onPressed: () {
                          if (currentMethod == null) {
                            EasyLoading.showError(
                                'A payment method must be selected');
                          }
                          if (currentMethod == PaymentMethod.creditCard) {
                            Navigator.pushNamed(
                                context, RouteList.creditCardForm, arguments: {
                              'paymentCubit': context.read<PaymentCubit>()
                            });
                          } else if (currentMethod == PaymentMethod.debitCard) {
                            paymentCubit.paymentRequested(
                                matchId: matchId,
                                paymentMethod: currentMethod!);
                          } else if (currentMethod ==
                              PaymentMethod.tokenization) {
                            paymentCubit.paymentRequested(
                                matchId: matchId,
                                paymentMethod: currentMethod!,
                                sequenceType: SequenceType.recurring,
                                methodToken: selectedCardToken);
                          } else if (currentMethod == PaymentMethod.googlePay) {
                            paymentCubit.onNativePayPressed(
                                price: 100, provider: PayProvider.google_pay);
                          }
                        },
                      ),
      ),
    );
  }
}
