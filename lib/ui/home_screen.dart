import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/core/style.dart';
import 'package:client/ui/events_screen.dart';
import 'package:client/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/main_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String username =
        context.watch<AuthBloc>().state.user?.username ?? 'null';
    final String uid = context.watch<AuthBloc>().state.user?.id ?? 'null';
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      endDrawer: MainDrawer(
        height: height,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => context.go('/home/create-event'),
          radius: 32,
          borderRadius: BorderRadius.circular(21),
          child: const Icon(
            CupertinoIcons.add_circled_solid,
            size: 60,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              MainAppbar(
                height: height,
                username: username,
                openDrawer: () => Scaffold.of(context).openEndDrawer(),
              ),
            ];
          },
          body: TabBarView(
            children: [
              EventsScreen(
                uid: uid,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Friends',
                    style: AppTheme.mainStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
