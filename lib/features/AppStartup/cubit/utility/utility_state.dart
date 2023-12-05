part of 'utility_cubit.dart';

class UtilityState extends Equatable {
  final List<SportCategoryModel>? sCategoriesList;
  factory UtilityState.initial() {
    return const UtilityState();
  }

  const UtilityState({this.sCategoriesList});

  UtilityState copyWith({
    List<SportCategoryModel>? sCategoriesList,
  }) {
    return UtilityState(
      sCategoriesList: sCategoriesList ?? this.sCategoriesList,
    );
  }

  @override
  List<Object?> get props => [sCategoriesList];
}
