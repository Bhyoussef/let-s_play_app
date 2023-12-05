import 'package:flutter/material.dart';
import 'package:lets_play/models/local/coaching_model.dart';

import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';

class CoachingList extends StatelessWidget {
  final List<CoachingModel> mockedList;
  const CoachingList({Key? key, required this.mockedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Scaffold(
      backgroundColor: AppColors.backGrey,
      body: Column(
        children: [
          Container(
            height: 2,
            color: Colors.white,
          ),
          if (false)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              color: AppColors.purple,
              child: Row(
                children: [
                  Image.asset(
                    Assets.filterIcon,
                    height: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Wednesday 31 Aug", style: AppStyles.mont13Medium.withColor(Colors.white))
                ],
              ),
            ),
          Expanded(
              child: ListView.builder(
            itemCount: mockedList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final field = mockedList[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(20),
                  height: 262,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(field.name, style: AppStyles.inter17Bold),
                          Text(field.date, style: AppStyles.inter13w500),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 86,
                        decoration: BoxDecoration(
                            image:
                                DecorationImage(image: AssetImage(field.photo), fit: BoxFit.fill)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${field.address} ',
                              style: AppStyles.inter14w500.withColor(Colors.black)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            height: 59,
                            width: 95,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: const BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('JOIN', style: AppStyles.inter11w500),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('QAR ${field.price}',
                                      style: AppStyles.inter15Bold.withColor(Colors.black)),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text('Per spot', style: AppStyles.inter10w500),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
