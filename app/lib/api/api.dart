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
        print('dupa0');
    var decoded = json.decode(response.body.toString());
    var token = decoded["token"];
    print('dupa1');
    var prefs = supaPrefs.getPrefs();
    await prefs.setString('token', token);

    var isConnected = await http.get("http://fitlocker.eu.ngrok.io/api/fit/google/connected-to-google", 
    headers: {"Authorization" : "Bearer $token"});

    print(isConnected.body);
    if (json.decode(isConnected.body)["connected"] == false) {
      var redirectUrl = await http.get("http://fitlocker.eu.ngrok.io/api/fit/google/connect", 
      headers: {"Authorization" : "Bearer $token"});
      _launchUrl(json.decode(redirectUrl.body)["redirectUrl"]);
    } 
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

final api = Api();