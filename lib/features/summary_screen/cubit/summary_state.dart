part of 'summary_cubit.dart';

class SummaryState extends Equatable {
  final Map<String, dynamic>? creationParams;
  final bool? processing;
  final PaymentModality? modality;
  final PublicPrivateType? publicPrivateType;
  final List<Map<String, dynamic>>? teamsForPartialPrivate;
  final Either<Failure, MatchModel>? matchCreationResult;
  final num?
      toBePaid; // amount to be paid after match creation, used as param to checkout_screen
  final String? attemptTime;
  const SummaryState({
    this.toBePaid,
    this.matchCreationResult,
    this.publicPrivateType,
    this.creationParams,
    this.processing,
    this.modality,
    this.teamsForPartialPrivate,
    this.attemptTime,
  });

  factory SummaryState.initial() {
    return const SummaryState(
      processing: false,
      modality: PaymentModality.partial,
      teamsForPartialPrivate: [],
      attemptTime: '',
    );
  }
  SummaryState copyWith({
    bool? processing,
    Map<String, dynamic>? creationParams,
    PaymentModality? modality,
    PublicPrivateType? publicPrivateType,
    List<Map<String, dynamic>>? teamsForPartialPrivate,
    Either<Failure, MatchModel>? matchCreationResult,
    String? attemptTime,
    num? toBePaid,
  }) {
    return SummaryState(
      processing: processing ?? this.processing,
      creationParams: creationParams ?? this.creationParams,
      modality: modality ?? this.modality,
      publicPrivateType: publicPrivateType ?? this.publicPrivateType,
      teamsForPartialPrivate:
          teamsForPartialPrivate ?? this.teamsForPartialPrivate,
      matchCreationResult: matchCreationResult ?? this.matchCreationResult,
      attemptTime: attemptTime ?? this.attemptTime,
      toBePaid: toBePaid ?? this.toBePaid,
    );
  }

  @override
  List<Object?> get props => [
        processing,
        creationParams,
        modality,
        publicPrivateType,
        teamsForPartialPrivate,
        matchCreationResult,
        toBePaid,
        attemptTime
      ];
}
