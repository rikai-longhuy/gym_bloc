import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bloc/states/workout_states.dart';

import '../models/workout.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index));

  goHome() {
    emit(const WorkoutInitial());
  }
}
