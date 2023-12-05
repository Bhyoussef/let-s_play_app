import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lets_play/data/core/http/api_constants.dart';

import '../constants/app_constants.dart';

class MyNetworkImage extends StatelessWidget {
  const MyNetworkImage({
    Key? key,
    required this.picPath,
    this.fallBackAssetPath,
    this.height,
    this.width,
  }) : super(key: key);
  final String? picPath;
  final String? fallBackAssetPath;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Builder(builder: (context) {
        if (picPath != null) {
          final addDomainPath = !picPath!.contains('http');
          return CachedNetworkImage(
            imageUrl: (addDomainPath ? ApiConstants.imageUrl : '') + picPath!,
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColors.lightPurple,
              )),
            ),
            errorWidget: (context, url, error) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                )),
              ],
            ),
            fit: BoxFit.cover,
          );
        } else {
          return Image.asset(
            fallBackAssetPath!,
            fit: BoxFit.cover,
          );
        }
      }),
    );
  }
}
