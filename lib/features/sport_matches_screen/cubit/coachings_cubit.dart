import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coachings_state.dart';

class CoachingsCubit extends Cubit<CoachingsState> {
  CoachingsCubit() : super(CoachingsInitial());
}
