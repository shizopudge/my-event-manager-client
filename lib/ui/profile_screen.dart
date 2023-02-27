import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/core/style.dart';
import 'package:client/widgets/delete_button.dart';
import 'package:client/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants.dart';
import '../data/user/models/user.dart';
import '../widgets/profile_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user = context.select<AuthBloc, User?>(
      (bloc) => bloc.state.user,
    );
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTheme.mainStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: '$baseUrl/${user?.pic}',
                imageBuilder: (context, imageProvider) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        radius: 120,
                        backgroundImage: imageProvider,
                      ),
                      Positioned(
                        top: 25,
                        right: 10,
                        child: InkWell(
                          onTap: () {},
                          radius: 32,
                          borderRadius: BorderRadius.circular(21),
                          child: Icon(
                            Icons.edit,
                            size: 36,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                placeholder: (context, url) => CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.grey.shade700,
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.grey.shade700,
                  child: const Icon(
                    Icons.error,
                    size: 55,
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
            ProfileTextField(
              text: user?.email,
              label: 'Email',
              icon: Icons.email,
            ),
            ProfileTextField(
              text: user?.username,
              label: 'Username',
              icon: Icons.alternate_email,
              //data_usage
            ),
            SubmitButton(
              content: Text(
                'Edit password',
                style: AppTheme.mainStyle,
              ),
              onTap: () {},
              height: height * .08,
              width: width,
            ),
          ],
        ),
      ),
    );
  }
}
