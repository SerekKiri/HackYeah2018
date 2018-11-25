class App {
  final int id;
  final int costPerMinute;
  final String appIndentifier;
  final String friendlyName;

  double minutesLeft;

  App.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        costPerMinute = json['costPerMinute'],
        friendlyName = json['friendlyName'],
        appIndentifier = json['appIdentifier'],
        minutesLeft =
            json["allowance"] == null ? 0.0 : json["allowance"]["minutesLeft"].toDouble();
}
