import 'package:shared_preferences/shared_preferences.dart';

class SupaPrefs {
  SharedPreferences supaPrefs;
  Future<void> init() async {
    supaPrefs = await SharedPreferences.getInstance();
  }

  SharedPreferences getPrefs() {
    return this.supaPrefs;
  }
}

final supaPrefs = SupaPrefs();
