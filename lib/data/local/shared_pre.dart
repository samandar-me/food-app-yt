import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  void saveMealType(int index) async {
    final shared = await SharedPreferences.getInstance();
    shared.setInt('meal', index);
  }
  Future<int> getMealType() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getInt('meal') ?? 0;
  }

  void saveDietType(int index) async {
    final shared = await SharedPreferences.getInstance();
    shared.setInt('diet', index);
  }
  Future<int> getDietType() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getInt('diet') ?? 0;
  }
}