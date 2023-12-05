import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/features/payment/models/dibsy_card.dart';
import 'package:lets_play/features/payment/models/payment_method.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';

import '../../../common/components/custom_radioBox.dart/CustomRadioboxWidget.dart';
import '../../../common/constants/app_constants.dart';
import '../../../common/constants/assets_images.dart';
import 'dart:io' as io;

class PayWithSection extends StatefulWidget {
  final Function(PaymentMethod) paymentMethodCallback;
  final Function(String) tokenizationCardTokenCallback;
  const PayWithSection(
      {Key? key,
      required this.paymentMethodCallback,
      required this.tokenizationCardTokenCallback})
      : super(key: key);

  @override
  State<PayWithSection> createState() => _PayWithSectionState();
}

class _PayWithSectionState extends State<PayWithSection> {
  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.read<UserCubit>();
    List<DibsyCard> cards = List.from(userCubit.state.user!.savedCards!);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (io.Platform.isIOS)
                Row(
                  children: [
                    CustomRadioboxWidget(
                      activeBgColor: Colors.white,
                      customBgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveBorderColor: AppColors.disabledGrey,
                      size: 25,
                      value: 0,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value as int;
                        });
                        widget.paymentMethodCallback(PaymentMethod.applePay);
                      },
                      activeBorderColor: AppColors.purple,
                      radioColor: AppColors.purple,
                      inactiveRadioColor: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    paymentImageContainer(Assets.applePay),
                    const SizedBox(width: 16),
                    const Text('Apple Pay', style: AppStyles.inter13SemiBold),
                  ],
                ),
              if (io.Platform.isIOS) const SizedBox(height: 20),
              if (io.Platform.isAndroid)
                Row(
                  children: [
                    CustomRadioboxWidget(
                      activeBgColor: Colors.white,
                      customBgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveBorderColor: AppColors.disabledGrey,
                      size: 25,
                      value: cards.length + 3,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value as int;
                        });
                        widget.paymentMethodCallback(PaymentMethod.googlePay);
                      },
                      activeBorderColor: AppColors.purple,
                      radioColor: AppColors.purple,
                      inactiveRadioColor: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    paymentImageContainer(Assets.googlePay),
                    const SizedBox(width: 16),
                    const Text('Google Pay', style: AppStyles.inter13SemiBold),
                  ],
                ),
              if (io.Platform.isAndroid) const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomRadioboxWidget(
                        activeBgColor: Colors.white,
                        customBgColor: Colors.white,
                        inactiveBgColor: Colors.white,
                        inactiveBorderColor: AppColors.disabledGrey,
                        size: 25,
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value as int;
                          });
                          widget.paymentMethodCallback(PaymentMethod.debitCard);
                        },
                        activeBorderColor: AppColors.purple,
                        radioColor: AppColors.purple,
                        inactiveRadioColor: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      paymentImageContainer(Assets.napsCard),
                      const SizedBox(width: 16),
                      const Text('Qatar Debit Card',
                          style: AppStyles.inter13SemiBold),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomRadioboxWidget(
                        activeBgColor: Colors.white,
                        customBgColor: Colors.white,
                        inactiveBgColor: Colors.white,
                        inactiveBorderColor: AppColors.disabledGrey,
                        size: 25,
                        value: 2,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value as int;
                          });
                          widget
                              .paymentMethodCallback(PaymentMethod.creditCard);
                        },
                        activeBorderColor: AppColors.purple,
                        radioColor: AppColors.purple,
                        inactiveRadioColor: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      paymentImageContainer(Assets.creditCard),
                      const SizedBox(width: 16),
                      const Text('MasterCard / Visa',
                          style: AppStyles.inter13SemiBold),
                    ],
                  ),
                ],
              ),
              if (cards.isEmpty) const SizedBox(height: 20),
              // saved cards
              ...cards
                  .asMap()
                  .map((index, card) {
                    final isVisa =
                        card.providerType.toLowerCase().contains('visa');

                    return MapEntry(
                        index,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    CustomRadioboxWidget(
                                      activeBgColor: Colors.white,
                                      customBgColor: Colors.white,
                                      inactiveBgColor: Colors.white,
                                      inactiveBorderColor:
                                          AppColors.disabledGrey,
                                      size: 25,
                                      value: index + 1 + 2,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue = value as int;
                                        });
                                        widget.paymentMethodCallback(
                                            PaymentMethod.tokenization);
                                        widget.tokenizationCardTokenCallback(
                                            card.token);
                                      },
                                      activeBorderColor: AppColors.purple,
                                      radioColor: AppColors.purple,
                                      inactiveRadioColor: Colors.white,
                                    ),
                                    const SizedBox(width: 20),
                                    paymentImageContainer(
                                      isVisa
                                          ? Assets.visaCardIcon
                                          : Assets.masterCardIcon,
                                    ),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      child: Text(
                                        'xxxx-' +
                                            card.lastDigits +
                                            ' : ${card.holderName.capitalizeEveryWord}',
                                        style: AppStyles.inter13SemiBold,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  })
                  .values
                  .toList(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 1,
                  color: AppColors.backGrey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget paymentImageContainer(String imagePath) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyText, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Image.asset(
        imagePath,
        width: 42,
      ),
    );
  }
}
