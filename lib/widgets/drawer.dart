import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/core/constants.dart';
import 'package:client/core/style.dart';
import 'package:client/data/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainDrawer extends StatelessWidget {
  final double height;
  const MainDrawer({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final User? user = context.select<AuthBloc, User?>(
      (bloc) => bloc.state.user,
    );
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SizedBox(
            height: height * .5,
            child: Align(
              alignment: Alignment.topRight,
              child: Drawer(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(21),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: '$baseUrl/${user?.pic}',
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 55,
                            backgroundImage: imageProvider,
                          );
                        },
                        placeholder: (context, url) => CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade700,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 55,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onTap: () => context.go('/home/profile'),
                        tileColor: Colors.grey.shade700,
                        leading: const Icon(
                          Icons.person,
                          size: 32,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Profile',
                          style: AppTheme.mainStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onTap: () => context.go('/home/settings'),
                        tileColor: Colors.grey.shade700,
                        leading: const Icon(
                          Icons.settings,
                          size: 32,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Settings',
                          style: AppTheme.mainStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onTap: () {
                          context.read<AuthBloc>().add(
                                AuthLogoutEvent(context: context),
                              );
                          context.go('/');
                        },
                        tileColor: Colors.grey.shade700,
                        leading: const Icon(
                          Icons.logout_rounded,
                          size: 32,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Logout',
                          style: AppTheme.mainStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
