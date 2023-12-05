import 'package:flutter/material.dart';
import 'package:lets_play/common/components/yellow_banner/yellow_banner.dart';

class ClickableYellowBanner extends StatelessWidget {
  final String title ;
  final Function callback;

  const ClickableYellowBanner({Key? key, required this.title, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        callback();
      },child: YellowBanner(title: title,),
    );
  }
}
