import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPassCubit extends Cubit<bool> {
  ShowPassCubit() : super(false);

  void show() => emit(true);
  void hide() => emit(false);
}
