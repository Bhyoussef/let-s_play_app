import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/components/custom_radioBox.dart/CustomRadioboxWidget.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'package:lets_play/features/home_search/cubit/home_search_cubit.dart';
import 'package:lets_play/features/home_search/models/search_entity_type.dart';

class PlaygroundOrMatchPickerWidget extends StatefulWidget {
  const PlaygroundOrMatchPickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PlaygroundOrMatchPickerWidget> createState() =>
      _PlaygroundOrMatchPickerWidgetState();
}

class _PlaygroundOrMatchPickerWidgetState
    extends State<PlaygroundOrMatchPickerWidget> {
  int groupValue = 0;
  late HomeSearchCubit searchCubit;
  @override
  void initState() {
    super.initState();
    searchCubit = context.read<HomeSearchCubit>();
    groupValue =
        searchCubit.state.selectedEntityType! == SearchEntityType.playground
            ? 0
            : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                  searchCubit.selectedEntityTypeChanged(
                      entityType: SearchEntityType.playground);
                },
                activeBorderColor: AppColors.purple,
                radioColor: AppColors.purple,
                inactiveRadioColor: Colors.white,
              ),
              const SizedBox(width: 20),
              const Text('Playgrounds', style: AppStyles.inter13SemiBold),
            ],
          ),
          const SizedBox(width: 20),
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
                  searchCubit.selectedEntityTypeChanged(
                      entityType: SearchEntityType.match);
                },
                activeBorderColor: AppColors.purple,
                radioColor: AppColors.purple,
                inactiveRadioColor: Colors.white,
              ),
              const SizedBox(width: 20),
              const Text('Matches', style: AppStyles.inter13SemiBold),
            ],
          ),
        ],
      ),
    );
  }
}
