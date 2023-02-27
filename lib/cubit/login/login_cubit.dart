import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenCubit extends Cubit<bool> {
  LoginScreenCubit() : super(true);

  void login() => emit(true);
  void registration() => emit(false);
}
