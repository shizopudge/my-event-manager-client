import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/core/style.dart';
import 'package:client/cubit/tabs/tabs_controller.dart';
import 'package:client/ui/app_menu_screen.dart';
import 'package:client/ui/events_screen.dart';
import 'package:client/ui/friends_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/floating_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(
        () =>
            context.read<TabControllerCubit>().currentTab(_tabController.index),
      );
  }

  @override
  Widget build(BuildContext context) {
    final String uid = context.watch<AuthBloc>().state.user?.id ?? 'null';
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final int currentTab = context.watch<TabControllerCubit>().state;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: currentTab == 0
          ? AddFloatingButton(
              isEvent: true,
              width: width * .45,
              height: height * .12,
            )
          : null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          indicatorWeight: 2.5,
          indicatorColor: Colors.blueGrey,
          controller: _tabController,
          onTap: (index) =>
              context.read<TabControllerCubit>().currentTab(index),
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Events',
                  style: AppTheme.hintStyle,
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Friends',
                  style: AppTheme.hintStyle,
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: AppTheme.hintStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: TabBarView(
          controller: _tabController,
          children: [
            EventsScreen(
              uid: uid,
            ),
            FriendsScreen(
              uid: uid,
            ),
            const AppMenu(),
          ],
        ),
      ),
    );
  }
}
