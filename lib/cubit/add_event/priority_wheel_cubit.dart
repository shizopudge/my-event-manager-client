import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventPriorityWheelCubit extends Cubit<String> {
  AddEventPriorityWheelCubit() : super('Low');

  void setPriority(String priority) => emit(priority);
}
