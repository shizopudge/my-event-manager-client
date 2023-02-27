import 'package:client/core/style.dart';
import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget {
  final double height;
  final String username;
  final void Function()? openDrawer;
  const MainAppbar({
    super.key,
    required this.height,
    required this.username,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: openDrawer,
            child: const Icon(
              Icons.menu_outlined,
              size: 32,
            ),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 75),
        title: Text(
          'Hi, $username',
          style: AppTheme.mainStyle,
        ),
      ),
      bottom: TabBar(
        indicatorWeight: 1,
        indicatorColor: Colors.blueGrey.shade100,
        tabs: [
          Tab(
            icon: Image.asset(
              'assets/icons/checklist.png',
              color: Colors.blueGrey.shade100,
              fit: BoxFit.cover,
            ),
          ),
          Tab(
            icon: Image.asset(
              'assets/icons/friends.png',
              color: Colors.blueGrey.shade100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      expandedHeight: height * .4,
    );
  }
}
