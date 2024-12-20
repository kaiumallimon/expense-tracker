import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  // Initialize the cubit with the stored preference
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool('darkMode') ?? false);
  }

  // Toggle the dark mode and store the preference
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool currentTheme = state;
    bool newTheme = !currentTheme;
    prefs.setBool('darkMode', newTheme);
    emit(newTheme);
  }
}
