import 'package:client/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/login/show_pass_cubit.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPass;
  final bool isEmail;
  final String hint;
  final String? Function(String?)? validator;
  const LoginTextField({
    super.key,
    required this.controller,
    this.isPass = false,
    this.isEmail = false,
    required this.hint,
    required this.validator,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    final bool showPass = context.watch<ShowPassCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.blueGrey.shade900,
            child: TextFormField(
              controller: widget.controller,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp('[ ]'),
                ),
              ],
              obscureText: showPass ? false : widget.isPass,
              keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
              style: AppTheme.mainStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15),
                hintText: widget.hint,
                hintStyle: AppTheme.mainStyle,
                errorStyle:
                    AppTheme.hintStyle.copyWith(color: Colors.red.shade300),
                suffixIcon: widget.isPass
                    ? GestureDetector(
                        onTap: () => showPass
                            ? context.read<ShowPassCubit>().hide()
                            : context.read<ShowPassCubit>().show(),
                        child: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off,
                          color: showPass ? Colors.white : Colors.grey,
                        ),
                      )
                    : null,
              ),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
