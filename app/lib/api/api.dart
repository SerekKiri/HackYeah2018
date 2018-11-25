import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fitlocker/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitlocker/models/app.dart';

class Api {
  String token;
  Map<String, String> get getHeaders => {'Authorization': 'Bearer $token'};
  Map<String, String> get postHeaders =>
      {}..addAll(getHeaders)..addAll({'Content-Type': 'application/json'});
  final String host = 'http://fitlocker.eu.ngrok.io/api';

  loginUser(Map data) async {
    await supaPrefs.init();
    var user = json.encode(data);
    var url = '$host/auth/login';
    var response = await http.post(url,
        body: user, headers: Map.from({"Content-Type": "application/json"}));
    var decoded = json.decode(response.body);
    var token = decoded["token"];
    var prefs = supaPrefs.getPrefs();
    await prefs.setString('token', token);
    this.token = token;

    var isConnected = await http.get('$host/fit/google/connected-to-google',
        headers: getHeaders);

    print(isConnected.body);
    if (json.decode(isConnected.body)["connected"] == false) {
      var redirectUrl =
          await http.get('$host/fit/google/connect', headers: getHeaders);
      await _launchUrl(json.decode(redirectUrl.body)["redirectUrl"]);
    }
  }

  Future addApp(String friendlyName, String packageName, int cost) async {
    await ensureToken();
    var response = await http.post('$host/fit/tracked-apps',
        body: json.encode(Map.from({
          "appType": "androidApp",
          "appIdentifier": packageName,
          "costPerMinute": cost,
          "friendlyName": friendlyName
        })),
        headers: postHeaders);
    print(response.body);
  }

  redeemPoints(int appId, int minutes) async {
    await ensureToken();
    var response = await http.post('$host/fit/tracked-apps/$appId/redeem',
        body: json.encode(Map.from({"minutes": minutes})),
        headers: postHeaders);
    print(response.body);
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<List<App>> fetchApps() async {
    await ensureToken();
    var response =
        await http.get('$host/fit/tracked-apps', headers: getHeaders);

    return (List.from(json.decode(response.body)).map((item) {
      return App.fromJson(item);
    }))
        .toList();
  }

  Future convertActivity(Map activityObj) async {
    await ensureToken();
    var response = await http.post('$host/fit/google/convert',
        headers: getHeaders, body: json.encode(activityObj));
  }

  Future<List<Map>> getConvertableActivities(Map activityObj) async {
    await ensureToken();
    var response = await http.get('$host/fit/google/convertable-calories',
        headers: getHeaders);
    return json.decode(response.body);
  }

  ensureToken() async {
    if (token == null) {
      await supaPrefs.init();
      token = supaPrefs.getPrefs().getString('token');
    }
  }
}

final api = Api();
