import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventColorPickerCubit extends Cubit<String> {
  AddEventColorPickerCubit() : super('0xfff7f7f7');

  void pickColor(String color) => emit(color);
}
