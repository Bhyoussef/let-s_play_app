import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/features/profile_settings/widgets/AvatarpickerWidget.dart';
import 'package:lets_play/routes/routes_list.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileSettingsState();
  }
}

class ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        elevation: 2,
        centerTitle: false,
        title: const Text("Settings", style: AppStyles.mont23SemiBold),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Center(
              child: Image.asset(
                Assets.backBtn,
                height: 22,
                color: Colors.white,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 42,
            ),
            AvatarPickerWidget(
              onAvatarPicked: (value) {
                if (value != null) {
                  context
                      .read<UserCubit>()
                      .changeProfileAvatar(pickedAvatarPath: value);
                }
              },
            ),
            const SizedBox(height: 32),
            profileTile(Icons.account_circle, 'My profile', () {
              Navigator.pushNamed(context, RouteList.profileScreen);
            }),
            profileTile(Icons.lock_open_outlined, 'Change password', () {
              Navigator.pushNamed(context, RouteList.changePasswordScreen);
            }),
            profileTile(Icons.bookmark_add, 'Favorite sports', () {
              Navigator.pushNamed(context, RouteList.selectFavSport,
                  arguments: {'isUpdate': true});
            }),
            profileTile(Icons.favorite, 'Favorite playgrounds', () {
              Navigator.pushNamed(context, RouteList.favPlaygroundsScreen);
            }),
            profileTile(Icons.payment_outlined, 'My payment cards', () {
              Navigator.pushNamed(context, RouteList.userPaymentCardsScreen);
            }),
            profileTile(Icons.support_agent_outlined, 'Support chat', () {
              Navigator.pushNamed(context, RouteList.ebChatScreen);
            }),
            profileTile(Icons.logout, 'Sign out', () {
              context.read<UserCubit>().logout();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, RouteList.landing);
            }),
            const SizedBox(
              height: 42,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileTile(IconData icon, String title, Function callback) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: 64,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: AppColors.purple.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.pink,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: AppStyles.mont16Bold,
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 32,
            )
          ],
        ),
      ),
    );
  }
}
