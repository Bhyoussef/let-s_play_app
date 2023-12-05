import 'package:credit_card_form/screens/credit_card_form/credit_card_form.dart';
import 'package:credit_card_form/theme.dart';
import 'package:credit_card_form/utils/env/environments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/payment/cubit/payment_cubit.dart';
import 'package:lets_play/features/payment/models/payment_sequence.dart';

class DibsyCreditCard extends StatefulWidget {
  const DibsyCreditCard({
    Key? key,
    required this.paymentCubit,
  }) : super(key: key);
  final PaymentCubit paymentCubit;
  @override
  State<DibsyCreditCard> createState() => _DibsyCreditCardState();
}

class _DibsyCreditCardState extends State<DibsyCreditCard> {
  @override
  void initState() {
    super.initState();

    /// Must call Dibsy init
    initializeDibsy(
      env: DibsyEnvironnement.test,
      pkTest: 'pk_test_E6R2foHHxMwLyYBcH62kwZpWDdlaxDP1684I',
      pkLive: 'pk_live_Jc6fHRCWlHtbY31LM93tCRhUeuE5BVCLM4Gu',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.paymentCubit,
      child: const DibsyCreditCardContent(),
    );
  }
}

class DibsyCreditCardContent extends StatelessWidget {
  const DibsyCreditCardContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: appThemeData(context).copyWith(
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            )),
        child: CreditCardForm(
          onSuccess: (success) {
            context.read<PaymentCubit>().creditCardTokenSucceded(
                token: success.cardToken,
                sequenceType: success.tokenizeCard
                    ? SequenceType.recurring
                    : SequenceType.oneOff);
            Navigator.pop(context);
            EasyLoading.dismiss();
          },
          onFailure: (value) {
            print(value);
            EasyLoading.dismiss();
          },
          onProcessing: () {
            EasyLoading.show();
          },
        ));
  }
}
