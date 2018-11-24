import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fitlocker/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitlocker/models/app.dart';

class Api {

  loginUser(Map data) async {
    await supaPrefs.init();
    var user = json.encode(data);
    var url = 'http://fitlocker.eu.ngrok.io/api/auth/login';
    var response = await http.post(url,
        body: user, headers: Map.from({"Content-Type": "application/json"}));
    var decoded = json.decode(response.body);
    var token = decoded["token"];
    var prefs = supaPrefs.getPrefs();
    await prefs.setString('token', token);

    var isConnected = await http.get(
        "http://fitlocker.eu.ngrok.io/api/fit/google/connected-to-google",
        headers: {"Authorization": "Bearer $token"});

    print(isConnected.body);
    if (json.decode(isConnected.body)["connected"] == false) {
      var redirectUrl = await http.get(
          "http://fitlocker.eu.ngrok.io/api/fit/google/connect",
          headers: {"Authorization": "Bearer $token"});
      await _launchUrl(json.decode(redirectUrl.body)["redirectUrl"]);
    }
  }

  Future addApp(String friendlyName, String packageName, int cost) async {
    var user = json.encode(Map.from({
      "appType": "androidApp",
      "appIdentifier": packageName,
      "costPerMinute": cost,
      "friendlyName": friendlyName
    }));
    await supaPrefs.init();
    var token = await supaPrefs.getPrefs().getString('token');
    var url = 'http://fitlocker.eu.ngrok.io/api/fit/tracked-apps';
    var response = await http.post(url,
        body: user,
        headers: Map.from({
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }));
    print(response.body);
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<List<App>> fetchApps() async {
    await supaPrefs.init();
    var token = supaPrefs.getPrefs().getString('token');
    var url = "http://fitlocker.eu.ngrok.io/api/fit/tracked-apps";
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    return (List.from(json.decode(response.body)).map((item) {
      return App.fromJson(item);
    }))
        .toList();
  }
}

final api = Api();
