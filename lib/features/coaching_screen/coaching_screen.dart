import 'package:flutter/material.dart';
import 'package:lets_play/features/coaching_screen/coaching_list.dart';

import '../../common/constants/constants.dart';

class CoachingScreen extends StatefulWidget {
  const CoachingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CoachingScreenState();
  }
}

class CoachingScreenState extends State<CoachingScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return CoachingList(mockedList: mockedCoaching);
  }
}
