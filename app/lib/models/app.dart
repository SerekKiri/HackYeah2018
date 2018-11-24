class AppsList {
  List<App> apps;
}

class App {
  final int costPerMinute;
  final String appIndentifier;
  final String friendlyName;


    App.fromJson(Map<String, dynamic> json)
      : costPerMinute = json['costPerMinute'],
        friendlyName = json['friendlyName'],
        appIndentifier = json['appIndentifier'];
}