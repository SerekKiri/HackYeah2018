class Activity {
  final int code;
  final String name;
  final int calories;
  final int points;
  final bool alreadyConverted;

  Activity.fromJson(Map<String, dynamic> json)
      : code = json['activityCode'].toInt(),
        name = json['activityName'],
        calories = json['calories'].toInt(),
        points = json['points'].toInt(),
        alreadyConverted = json['alreadyConverted'];

  Map<String, dynamic> toJson() {
    return Map.from({
      code: code,
      name: name,
      calories: calories,
      points: points,
      alreadyConverted: alreadyConverted
    });
  }
}
