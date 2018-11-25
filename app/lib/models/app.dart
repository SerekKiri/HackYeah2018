class App {
  final int id;
  final int costPerMinute;
  final String appIndentifier;
  final String friendlyName;

  App.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        costPerMinute = json['costPerMinute'],
        friendlyName = json['friendlyName'],
        appIndentifier = json['appIdentifier'];
}
