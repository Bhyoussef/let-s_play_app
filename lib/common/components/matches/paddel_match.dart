import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/assets_images.dart';

class PadelMatch extends StatefulWidget {
  const PadelMatch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PadelMatchState();
  }
}

class PadelMatchState extends State<PadelMatch> {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.padelField)
        )
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              paddelFilledField(1, "Mahmoud ahmed"),
              _paddelEmptyField(),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              paddelFilledField(2, "Mohmed zein"),
              _paddelEmptyField(),
            ],
          ),

        ],
      ),
    );
  }

  Widget _paddelEmptyField(){
    return SizedBox(
        width: 88,
        child:
        Column(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all( Radius.circular(15)),
            border: Border.all(color: AppColors.purple, width: 1)
          ),
        ),
        const SizedBox(height: 4,),
        Text('Available',
            style: AppStyles.inter9w300.withColor(Colors.black))
      ],
    ));
  }

  Widget paddelFilledField(int index, String name){
    return SizedBox(
      width: 88,
      child:
      Column(
        children: [
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all( Radius.circular(15)),
                  color: AppColors.purple
              ),
              child: Center(
                child:  Text('$index',
                    style: AppStyles.inter15w500.withColor(Colors.white)),
              )
          ),
          const SizedBox(height: 4,),
          Text(name,
              style: AppStyles.inter9w300.withColor(Colors.black))
        ],
      ),
    );
  }

}