import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth/auth_bloc.dart';
import '../core/constants.dart';
import '../data/user/models/user.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final User? user = context.select<AuthBloc, User?>(
      (bloc) => bloc.state.user,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CachedNetworkImage(
                    imageUrl: '$baseUrl/${user?.pic}',
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 75,
                        backgroundImage: imageProvider,
                      );
                    },
                    placeholder: (context, url) => CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey.shade700,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey.shade700,
                      child: const Icon(
                        Icons.error,
                        size: 32,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  '@${user?.username}',
                  style: AppTheme.hintStyle,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                gradient: LinearGradient(
                  colors: [
                    Colors.blueGrey.shade900,
                    Colors.grey.shade900,
                  ],
                ),
              ),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () => context.go('/home/profile'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 42,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          'Profile',
                          style: AppTheme.mainStyle,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.settings,
                          size: 42,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          'Settings',
                          style: AppTheme.mainStyle,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => context.goNamed(
                      'stats',
                      queryParams: {
                        'id': user?.id,
                      },
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.assessment_rounded,
                          size: 42,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          'Stats',
                          style: AppTheme.mainStyle,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<AuthBloc>().add(
                            AuthLogoutEvent(context: context),
                          );
                      context.go('/');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 42,
                          color: Colors.blueGrey,
                        ),
                        Text(
                          'Logout',
                          style: AppTheme.mainStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
