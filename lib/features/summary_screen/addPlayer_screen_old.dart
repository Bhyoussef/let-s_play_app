import 'package:flutter/material.dart';

import '../../common/components/yellow_submit_button.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import '../../common/components/searchTextField.dart';
import 'components/addPLayerScreen/EmptyPLayerPlaceholder.dart';

class AddPLayerScreen extends StatelessWidget {
  const AddPLayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:
          YellowSubmitButton(buttonText: 'Done', onPressed: () {}),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Add player', style: AppStyles.mont27bold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        // titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(
            Assets.backBtn,
            height: 21,
          ),
        ),
      ),
      body: Column(children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: List.generate(
                12,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                  child: EmptyPLayerPlaceholder(),
                ),
              ),
            ),
          ),
        ),
        const UsersListWidget(),
      ]),
    );
  }
}

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SearchTextField(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: AppColors.backGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Users',
                        style: AppStyles.inter15Bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: ((context, index) {
                          return const PlayerTileWidget();
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerTileWidget extends StatelessWidget {
  const PlayerTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  width: 51,
                  height: 51,
                  color: AppColors.purple,
                  child: Center(
                    child: Text(
                      'M',
                      style: AppStyles.inter20SemiBold
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Mahmoud ali',
                style: AppStyles.inter17w500.copyWith(color: Colors.black),
              ),
            ],
          ),
          const EmptyPLayerPlaceholder(),
        ],
      ),
    );
  }
}
