import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fitlocker/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Api {

  Future<Map> loginUser(Map data) async {
    await supaPrefs.init();
    var user = json.encode(data);
    var url = 'http://fitlocker.eu.ngrok.io/api/auth/login';
    var response = await http.post(url, body: user, headers: Map.from({
      "Content-Type": "application/json"
      }));
    var decoded = json.decode(response.body);
    var token = decoded["token"];
    var prefs = supaPrefs.getPrefs();
    await prefs.setString('token', token);

    var isConnected = await http.get("http://fitlocker.eu.ngrok.io/api/fit/google/connected-to-google", 
    headers: {"Authorization" : "Bearer $token"});

    print(isConnected.body);
    if (json.decode(isConnected.body)["connected"] == false) {
      var redirectUrl = await http.get("http://fitlocker.eu.ngrok.io/api/fit/google/connect", 
      headers: {"Authorization" : "Bearer $token"});
      await _launchUrl(json.decode(redirectUrl.body)["redirectUrl"]);
    } 
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<List<Map>> fetchApps() async {
    await supaPrefs.init();
    var token = await supaPrefs.getPrefs().getString('token');
    var url = "http://fitlocker.eu.ngrok.io/api/fit/tracked-apps";
    var response = await http.get(url, headers: {
      "Authorization" : "Bearer $token"
    });
    print(response.body);
  }
}

final api = Api();