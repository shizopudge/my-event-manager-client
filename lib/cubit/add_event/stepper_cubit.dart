import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventStepperCubit extends Cubit<int> {
  AddEventStepperCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void setStep(int step) => emit(step);
}
