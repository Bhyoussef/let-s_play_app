import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_play/common/constants/app_constants.dart';
import 'dart:io';

import '../../../common/components/MyNetworkImage.dart';
import '../../../common/constants/assets_images.dart';
import '../../../models/user.dart';
import '../../profile/cubit/user_cubit.dart';

class AvatarPickerWidget extends StatefulWidget {
  const AvatarPickerWidget({
    Key? key,
    required this.onAvatarPicked,
  }) : super(key: key);
  final ValueChanged<String?> onAvatarPicked;
  @override
  State<AvatarPickerWidget> createState() => _AvatarPickerWidgetState();
}

class _AvatarPickerWidgetState extends State<AvatarPickerWidget> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        User user = state.user!;
        return Column(
          children: [
            Center(
              child: SizedBox(
                width: 150.h,
                height: 150.h,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Center(
                      child: BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          return ClipOval(
                            child: imageFile == null
                                ? MyNetworkImage(
                                    picPath: state.user!.avatar,
                                    fallBackAssetPath: Assets.emoji,
                                    width: 140.h,
                                    height: 140.h,
                                  )
                                : Image.file(imageFile!, fit: BoxFit.cover),
                          );
                        },
                      ),
                    ),
                    if (imageFile != null || user.avatar != null)
                      InkWell(
                        onTap: () {
                          _imagePicker(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.purple),
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      )
                    else
                      InkWell(
                        onTap: () {
                          _imagePicker(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.purple),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        );
      },
    );
  }

  Future<void> _imagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedImage != null) {
      final CroppedFile? croppedImage =
          // ignore: use_build_context_synchronously
          await _cropImage(pickedImage.path, context);
      if (croppedImage != null) {
        imageFile = File(croppedImage.path);
        widget.onAvatarPicked(croppedImage.path);
        setState(() {});
      }
    }
  }

  _cropImage(String path, BuildContext context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Avatar",
          toolbarColor: AppColors.purple,
          toolbarWidgetColor: Colors.white,
          showCropGrid: false,
          activeControlsWidgetColor: AppColors.purple,
          backgroundColor: Colors.white,
          // initAspectRatio: CropAspectRatioPreset.original,
          hideBottomControls: true,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: "Avatar",
          aspectRatioLockEnabled: true,
        ),
      ],
    );
    return croppedFile;
  }
}
