import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/chat/cubit/chat_room_discussion_cubit.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatDiscussionScreen extends StatelessWidget {
  const ChatDiscussionScreen({super.key, this.match, this.friend});
  final MatchModel? match;
  final PlayerModel? friend;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ChatRoomDiscussionCubit(
        friend: friend,
        match: match,
        meUser: context.read<UserCubit>().state.user!,
      )
        ..getRoomMessages()
        ..initializePusherChannel(),
      child: ChatDiscussionContent(),
    );
  }
}

class ChatDiscussionContent extends StatelessWidget {
  final List<types.Message> _messages = [];

  ChatDiscussionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final letsUser = context.read<UserCubit>().state.user!;
    final _chatUser = types.User(id: letsUser.id.toString(), imageUrl: letsUser.avatar);
    final chatRoomDiscussionCubit = context.read<ChatRoomDiscussionCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Chat", style: AppStyles.mont27bold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(Assets.backBtn, height: 19, width: 21),
        ),
      ),
      body: BlocBuilder<ChatRoomDiscussionCubit, ChatRoomDiscussionState>(
        builder: (context, state) {
          if (state.mainStatus == MainStatus.loaded) {
            return Chat(
              customBottomWidget: const ChatCustomTextFieldWidget(),
              messages: state.roomMessages!,
              onSendPressed: (x) {}, // done custom
              showUserAvatars: true,
              showUserNames: true,
              user: _chatUser,
            );
          }
          return const LoadingScreen();
        },
      ),
    );
  }
}

class ChatCustomTextFieldWidget extends StatelessWidget {
  const ChatCustomTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRoomDiscussionCubit = context.read<ChatRoomDiscussionCubit>();

    return Container(
      padding: const EdgeInsets.only(bottom: 42, left: 20, right: 20),
      height: 106,
      color: AppColors.backGrey,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 43,
              child: TextFormField(
                  cursorColor: Colors.black,
                  controller: chatRoomDiscussionCubit.chatController,
                  onFieldSubmitted: (val) {
                    print(val);
                  },
                  onSaved: (message) {},
                  style: AppStyles.inter15w400,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Write a message ...",
                    hintStyle: AppStyles.inter15w400.withColor(const Color(0xFFACB1C0)),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Image.asset(Assets.chatIcon),
                      onPressed: () {
                        chatRoomDiscussionCubit.handleSendPressed();
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 0.5, color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(width: 0.5, color: Colors.transparent)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
