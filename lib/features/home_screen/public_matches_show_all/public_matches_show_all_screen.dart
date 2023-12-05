import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/common/components/paginationLoader.dart';
import 'package:lets_play/common/components/standard_close_appBar.dart';
import 'package:lets_play/features/Loading/loading_screen.dart';
import 'package:lets_play/features/home_screen/public_matches_show_all/cubit/all_available_public_matches_cubit.dart';
import 'package:lets_play/features/home_screen/public_matches_show_all/widgets/PublicMatchCard.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';
import 'package:lets_play/models/mainStatus.dart';

class PublicMatchesShowAllScreen extends StatelessWidget {
  const PublicMatchesShowAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildStandardCloseAppBar(
          context: context, title: 'Available Matches'),
      body: BlocProvider(
        create: (context) =>
            AllAvailablePublicMatchesCubit(context.read<UserCubit>()),
        child: AllAvailablePublicMathesContent(),
      ),
    );
  }
}

class AllAvailablePublicMathesContent extends StatefulWidget {
  @override
  State<AllAvailablePublicMathesContent> createState() =>
      _AllAvailablePublicMathesContentState();
}

class _AllAvailablePublicMathesContentState
    extends State<AllAvailablePublicMathesContent> {
  final _scrollController = ScrollController();
  late AllAvailablePublicMatchesCubit availablePMatchesCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    availablePMatchesCubit = context.read<AllAvailablePublicMatchesCubit>();
    availablePMatchesCubit.getAvailablePublicMatches();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_isBottom &&
        availablePMatchesCubit.state.mainStatus != MainStatus.loading) {
      await context
          .read<AllAvailablePublicMatchesCubit>()
          .getAvailablePublicMatches();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllAvailablePublicMatchesCubit,
        AllAvailablePublicMatchesState>(builder: (context, state) {
      if (state.mainStatus == MainStatus.initial ||
          state.mainStatus == MainStatus.failure) {
        return const LoadingScreen();
      } else {
        final matches = state.matches!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              controller: _scrollController,
              itemCount:
                  state.hasReachedMax! ? matches.length : matches.length + 1,
              itemBuilder: (context, index) {
                return index >= matches.length
                    ? const PaginationLoader()
                    : PublicMatchCardWidget(match: matches[index]);
              }),
        );
      }
    });
  }
}
