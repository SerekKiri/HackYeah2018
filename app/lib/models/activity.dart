class Activity {
  final int code;
  final String name;
  final int calories;
  final int points;
  final bool alreadyConverted;
  final int startTimeMilis;
  final int endTimeMilis;
  final String conversionHash;
  final Map<String, dynamic> originalJson;

  Activity.fromJson(Map<String, dynamic> json)
      : code = json['activityCode'].toInt(),
        name = json['activityName'],
        calories = json['calories'].toInt(),
        points = json['points'].toInt(),
        startTimeMilis = json['startTimeMilis'].toInt(),
        endTimeMilis = json['endTimeMilis'].toInt(),
        alreadyConverted = json['alreadyConverted'],
        conversionHash = json['conversionHash'],
        originalJson = json;

  Map<String, dynamic> toJson() {
    return originalJson;
  }

  String niceDuration() {
    return DateTime.fromMillisecondsSinceEpoch(startTimeMilis)
            .toLocal()
            .toString()
            .substring(0, 16) +
        " - " +
        DateTime.fromMillisecondsSinceEpoch(endTimeMilis)
            .toLocal()
            .toString()
            .substring(11, 16);
  }
}
