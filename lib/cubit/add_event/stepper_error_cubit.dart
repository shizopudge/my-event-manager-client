import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventStepperErrorCubit extends Cubit<bool> {
  AddEventStepperErrorCubit() : super(false);

  void error() => emit(true);
  void reset() => emit(false);
}
