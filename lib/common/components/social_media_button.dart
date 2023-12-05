import 'package:flutter/material.dart';

import '../../features/register/enums/social_media.dart';

class SocialMediaButton extends StatelessWidget {
  final SocialMedia socialMedia;

  const SocialMediaButton({Key? key, required this.socialMedia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
            )
          ]),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
        ),
        onPressed: () {},
        child: Center(
            child: Image.asset("assets/images/${socialMedia.logo}",
                width: 50, height: 50)),
      ),
    );
  }
}
