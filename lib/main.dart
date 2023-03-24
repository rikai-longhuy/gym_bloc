import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bloc/blocs/workout_cubit.dart';
import 'package:gym_bloc/screens/edit_workout_screen.dart';
import 'package:gym_bloc/screens/home_page.dart';
import 'package:gym_bloc/states/workout_states.dart';

import 'blocs/workouts_cubit.dart';
import 'models/workout.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Workouts',
        theme: ThemeData(
            primaryColor: Colors.blue,
            textTheme: const TextTheme(
              bodyText2: TextStyle(color: Color.fromARGB(155, 66, 74, 96)),
            )),
        home: /* BlocProvider<WorkoutsCubit>(
        create: (BuildContext context) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if (workoutsCubit.state.isEmpty) {
            print("....Loading json since the state is empty");
            workoutsCubit.getWorkouts();
          } else {
            print("...the state is not empty...");
          }

          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return const HomePage();
          },
        ),
      ),*/
            MultiBlocProvider(
          providers: [
            BlocProvider<WorkoutsCubit>(create: (BuildContext context) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                print("....Loading json since the state is empty");
                workoutsCubit.getWorkouts();
              } else {
                print("...the state is not empty...");
              }

              return workoutsCubit;
            }),
            BlocProvider<WorkoutCubit>(
                create: (BuildContext context) => WorkoutCubit())
          ],
          child: BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, state) {
              print("...point 1...");
              if (state is WorkoutInitial) {
                print("...point 2...");
                return const HomePage();
              } else if (state is WorkoutEditing) {
                print("...point 3...");
                return const EditWorkScreen();
              }
              print("...point 4...");
              return Container();
            },
          ),
        ));
  }
}
