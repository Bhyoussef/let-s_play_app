import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_play/features/match_details_screen/cubit/match_player_picker_cubit.dart';
import 'package:lets_play/features/pick_teams/models/player_model.dart';
import 'package:lets_play/models/mainStatus.dart';
import 'package:lets_play/models/server/match_model.dart';
import 'package:lets_play/data/services/match.dart' as matchService;
import 'package:lets_play/data/services/chat.dart' as chatService;

import '../../../data/core/errors/failures.dart';
part 'match_details_state.dart';

class MatchDetailsCubit extends Cubit<MatchDetailsState> {
  MatchDetailsCubit(this.matchPlayerPickerCubit) : super(MatchDetailsState.initial());
  final MatchPlayerPickerCubit matchPlayerPickerCubit;
  Future getMatchDetails({required int matchId}) async {
    final Either<Failure, MatchModel> response = await matchService.matchDetails(
      matchId: matchId,
    );

    return response.fold((l) {
      emit(state.copyWith(
        mainStatus: MainStatus.failure,
      ));
    }, (match) {
      if (match.isCreator!) {
        matchPlayerPickerCubit.getListPlayers();
      }
      emit(state.copyWith(
        mainStatus: MainStatus.loaded,
        match: match,
      ));
    });
  }

  Future joinMatch({required int matchId, required int position}) async {
    final isInTeamA = position < state.match!.playersPerTeam!;
    final teamId = isInTeamA ? state.match!.teamAId : state.match!.teamBId;
    final Either<Failure, Map<String, dynamic>> response = await matchService.joinMatch(
      matchId: matchId,
      teamId: teamId!,
      position: position,
    );
    response.fold(
        (l) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.failure,
                  action: CubitAction.join,
                ),
              ),
            ),
        (r) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.success,
                  action: CubitAction.join,
                  arguments: {"toBePaid": r['toBePaid']},
                ),
              ),
            ));
  }

  Future playerToInvitePicked({required PlayerModel player, required int position}) async {
    final isInTeamA = position < state.match!.playersPerTeam!;
    final teamId = isInTeamA ? state.match!.teamAId : state.match!.teamBId;
    final Either<Failure, Map<String, dynamic>> response = await matchService.invitePlayerToMatch(
      matchId: state.match!.id!,
      teamId: teamId!,
      position: position,
      playerId: player.id,
    );
    response.fold(
        (l) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.failure,
                  action: CubitAction.invite,
                ),
              ),
            ),
        (r) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                    status: CubitStatus.success,
                    action: CubitAction.invite,
                    arguments: {
                      "player": player,
                      "position": position,
                    }),
              ),
            ));
  }

  Future rejectInvite({required int matchId}) async {
    final Either<Failure, Map<String, dynamic>> response = await matchService.rejectInvite(
      matchId: matchId,
    );
    response.fold(
        (l) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.failure,
                  action: CubitAction.rejectInvite,
                ),
              ),
            ),
        (r) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.success,
                  action: CubitAction.rejectInvite,
                ),
              ),
            ));
  }

  Future creatorCancelsAPendingPlayer({required int matchId, required int playerId}) async {
    final Either<Failure, Map<String, dynamic>> response =

        /// TODO change to cancel pending player ep
        await matchService.creatorCancelsAPendingPlayer(matchId: matchId, playerId: playerId);
    response.fold(
        (l) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.failure,
                  action: CubitAction.cancelJoin,
                ),
              ),
            ),
        (r) => emit(
              state.copyWith(
                cubitOperation: CubitOperation(
                  status: CubitStatus.success,
                  action: CubitAction.cancelJoin,
                ),
              ),
            ));
  }

  Future joinChatMatch({required int roomId}) async {
    await chatService.joinChatRoom(roomId: roomId);
  }
}
