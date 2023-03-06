import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/style.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';
import '../data/user/models/user.dart';

class UserWidget extends StatelessWidget {
  final User user;
  final void Function() onTap;
  const UserWidget({
    super.key,
    required this.onTap,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(21),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900,
              Colors.grey.shade800,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: '$baseUrl/${user.pic}',
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 32,
                        backgroundImage: imageProvider,
                      );
                    },
                    placeholder: (context, url) => CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.grey.shade700,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.grey.shade700,
                      child: const Icon(
                        Icons.error,
                        size: 32,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        user.username,
                        style: AppTheme.hintStyle,
                      ),
                      Text(
                        user.email,
                        style: AppTheme.smallStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
