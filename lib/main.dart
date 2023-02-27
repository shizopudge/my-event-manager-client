import 'package:client/cubit/add_event/stepper_error_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/event/event_bloc.dart';
import 'bloc/events/events_bloc.dart';
import 'core/router.dart';
import 'core/style.dart';
import 'cubit/add_event/priority_wheel_cubit.dart';
import 'cubit/add_event/stepper_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/login/show_pass_cubit.dart';
import 'cubit/theme/theme_cubit.dart';
import 'data/auth/repository/auth_repository.dart';
import 'data/events/repository/events_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (context) => EventsBloc(
            eventsReposiotry: EventsReposiotry(),
          ),
        ),
        BlocProvider(
          create: (context) => EventBloc(
            eventsReposiotry: EventsReposiotry(),
          ),
        ),
        BlocProvider(
          create: (_) => LoginScreenCubit(),
        ),
        BlocProvider(
          create: (_) => ShowPassCubit(),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => AddEventStepperCubit(),
        ),
        BlocProvider(
          create: (_) => AddEventPriorityWheelCubit(),
        ),
        BlocProvider(
          create: (_) => AddEventStepperErrorCubit(),
        ),
      ],
      child: BlocSelector<ThemeCubit, String, String>(
        selector: (state) {
          return state;
        },
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state == 'dark' ? AppTheme.darkTheme : AppTheme.lightTheme,
            routerConfig: AppRouter.router,
            themeAnimationCurve: Curves.decelerate,
          );
        },
      ),
    );
  }
}
