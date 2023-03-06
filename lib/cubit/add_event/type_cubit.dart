import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventTypeCubit extends Cubit<String> {
  AddEventTypeCubit() : super('Other');

  void setType(String type) => emit(type);
}
