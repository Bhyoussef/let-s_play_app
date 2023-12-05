import 'package:equatable/equatable.dart';
import 'package:lets_play/models/server/match_model.dart';

class MatchResultModel extends Equatable {
  final String? next;
  final List<MatchModel>? matchesList;
  const MatchResultModel({this.matchesList, this.next});

  @override
  List<Object?> get props => [next, matchesList];
}

MatchResultModel formatMatchResultModel(map) {
  return MatchResultModel(
    next: map['next_page_url'],
    matchesList: List.from(map['data']).map(formatMatchModel).toList(),
  );
}
