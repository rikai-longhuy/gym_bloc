import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bloc/blocs/workout_cubit.dart';
import 'package:gym_bloc/helpers.dart';
import 'package:gym_bloc/models/exercise.dart';
import 'package:gym_bloc/states/workout_states.dart';

class EditWorkScreen extends StatelessWidget {
  const EditWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          WorkoutEditing we = state as WorkoutEditing;
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () =>
                    BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
            ),
            body: ListView.builder(
                itemCount: we.workout!.exercises.length,
                itemBuilder: (context, index) {
                  Exercise exercise = we.workout!.exercises[index];
                  return ListTile(
                    leading: Text(formatTime(exercise.prelude!, true)),
                  );
                }),
          ));
        },
      ),
      onWillPop: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
    );
  }
}
