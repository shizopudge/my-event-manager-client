import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/core/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/login/login_cubit.dart';
import '../widgets/login__text_field.dart';
import '../core/extensions.dart';
import '../widgets/logo.dart';
import '../widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _loginFormKey = GlobalKey<FormState>();
  final _registrationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.select<AuthBloc, bool>(
      (bloc) => bloc.state.isLoading,
    );
    final bool isError = context.select<AuthBloc, bool>(
      (bloc) => bloc.state.isError,
    );
    final bool isLogin = context.watch<LoginScreenCubit>().state;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bool keyboardShowed = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isLoggedIn) {
            context.go('/');
          }
        },
        builder: (context, state) {
          if (isError) {
            return SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong...\nTry again later',
                      textAlign: TextAlign.center,
                      style: AppTheme.mainStyle,
                    ),
                    SubmitButton(
                      content: Text(
                        'Reload',
                        style: AppTheme.mainStyle,
                      ),
                      onTap: () => context.go('/'),
                      height: height * .08,
                      width: width,
                    ),
                  ],
                ),
              ),
            );
          }
          if (isLogin) {
            return SafeArea(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: keyboardShowed
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    keyboardShowed
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              bottom: 25,
                            ),
                            child: Logo(
                              height: height,
                            ),
                          ),
                    LoginTextField(
                      controller: _emailController,
                      isEmail: true,
                      hint: 'Email',
                      validator: (value) {
                        if (value != null) {
                          if (!value.isValidEmail) {
                            return 'Enter valid email';
                          }
                        }
                        return null;
                      },
                    ),
                    LoginTextField(
                      controller: _passwordController,
                      isPass: true,
                      hint: 'Password',
                      validator: (value) {
                        if (value != null) {
                          if (!value.isValidPassword) {
                            return 'Enter valid password';
                          }
                          if (value.length < 9 || value.length > 21) {
                            return 'Enter valid password';
                          }
                        }
                        return null;
                      },
                    ),
                    SubmitButton(
                      onTap: isLoading
                          ? () {}
                          : () {
                              if (_loginFormKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthLoginEvent(
                                          context: context,
                                          email: _emailController.text,
                                          password: _passwordController.text),
                                    );
                              }
                            },
                      content: isLoading
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : Text(
                              'Login',
                              style: AppTheme.mainStyle,
                            ),
                      width: width,
                      height: height * .08,
                    ),
                    TextButton(
                      onPressed: () =>
                          context.read<LoginScreenCubit>().registration(),
                      child: Text(
                        'Dont have an account yet? Sign up!',
                        style: AppTheme.hintStyle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (!isLogin) {
            return SingleChildScrollView(
              physics: keyboardShowed
                  ? const ScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: SafeArea(
                child: Form(
                  key: _registrationFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                        ),
                        child: Logo(
                          height: height,
                        ),
                      ),
                      LoginTextField(
                        controller: _usernameController,
                        hint: 'Username',
                        validator: (value) {
                          if (value != null) {
                            if (!value.isValidUsername) {
                              return 'Enter valid username';
                            }
                          }
                          return null;
                        },
                      ),
                      LoginTextField(
                        controller: _emailController,
                        isEmail: true,
                        hint: 'Email',
                        validator: (value) {
                          if (value != null) {
                            if (!value.isValidEmail) {
                              return 'Enter valid email';
                            }
                          }
                          return null;
                        },
                      ),
                      LoginTextField(
                        controller: _passwordController,
                        isPass: true,
                        hint: 'Password',
                        validator: (value) {
                          if (value != null) {
                            if (!value.isValidPassword) {
                              return 'Enter valid password';
                            }
                            if (value.length < 9 || value.length > 21) {
                              return 'Enter valid password';
                            }
                          }
                          return null;
                        },
                      ),
                      LoginTextField(
                        controller: _confirmPasswordController,
                        isPass: true,
                        hint: 'Confirm password',
                        validator: (value) {
                          if (value != null) {
                            if (!value.isValidPassword) {
                              return 'Enter valid password';
                            }
                            if (value.length < 9 || value.length > 21) {
                              return 'Enter valid password';
                            }
                          }
                          return null;
                        },
                      ),
                      SubmitButton(
                        content: isLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            : Text(
                                'Sign up',
                                style: AppTheme.mainStyle,
                              ),
                        onTap: isLoading
                            ? () {}
                            : () {
                                if (_registrationFormKey.currentState!
                                    .validate()) {
                                  if (_passwordController.text ==
                                      _confirmPasswordController.text) {
                                    context.read<AuthBloc>().add(
                                          AuthRegistrationEvent(
                                              context: context,
                                              username:
                                                  _usernameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text),
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'The entered passwords do not match!'),
                                      ),
                                    );
                                  }
                                }
                              },
                        width: width,
                        height: height * .08,
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<LoginScreenCubit>().login(),
                        child: Text(
                          'Already have an account? Sign in!',
                          style: AppTheme.hintStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SafeArea(
            child: Center(
              child: Logo(
                height: height,
              ),
            ),
          );
        },
      ),
    );
  }
}
