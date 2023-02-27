import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<String> {
  ThemeCubit() : super('dark');

  // void setTheme() async {
  //   final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
  //   await sharedprefs.setString('theme', 'dark');
  // }

  Future<String> getTheme() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    final String? currentTheme = sharedprefs.getString('theme');
    return currentTheme ?? 'dark';
  }

  void toggleTheme() async {
    final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    final String? currentTheme = sharedprefs.getString('theme');
    if (currentTheme != null) {
      if (currentTheme == 'dark') {
        await sharedprefs.setString('theme', 'dark');
        emit('dark');
      } else {
        await sharedprefs.setString('theme', 'light');
        emit('light');
      }
    }
  }
}
