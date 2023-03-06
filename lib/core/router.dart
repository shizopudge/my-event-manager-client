import 'package:client/ui/app_menu_screen.dart';
import 'package:client/ui/event_screen.dart';
import 'package:client/ui/home_screen.dart';
import 'package:client/ui/login_screen.dart';
import 'package:client/ui/profile_screen.dart';
import 'package:client/ui/settings_screen.dart';
import 'package:client/ui/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/create_event_screen.dart';
import '../ui/splash_screen.dart';
import '../ui/stats_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileScreen();
            },
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
          GoRoute(
            path: 'create-event',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateEventScreen();
            },
          ),
          GoRoute(
            path: 'event',
            name: 'event',
            builder: (BuildContext context, GoRouterState state) {
              return EventScreen(
                id: state.queryParams['id'],
              );
            },
          ),
          GoRoute(
            path: 'user',
            name: 'user',
            builder: (BuildContext context, GoRouterState state) {
              return UserScreen(
                id: state.queryParams['id'],
              );
            },
          ),
          GoRoute(
            path: 'stats',
            name: 'stats',
            builder: (BuildContext context, GoRouterState state) {
              return StatsScreen(
                uid: state.queryParams['id'],
              );
            },
          ),
        ],
      ),
    ],
  );
}
