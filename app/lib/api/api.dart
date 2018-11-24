import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitlocker/utils/utils.dart';

class Api {
  final prefs = supaPrefs.getPrefs();

  Future<Map> loginUser(Map data) async {
    var user = json.encode(data);
    var url = 'http://fitlocker.eu.ngrok.io/api/auth/login';
    var response = await http.post(url, body: user, headers: Map.from({
      "Content-Type": "application/json"
      }));
    var dupa = json.decode(response.toString());
    dupa["token"];
  }
}

final api = Api();