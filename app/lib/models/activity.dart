class Activity {
  final int code;
  final String name;
  final double calories;
  final int points;
  final bool alreadyConverted;


  Activity.fromJson(Map<String, dynamic> json)
    : code = json['activityCode'],
      name = json['activityName'],
      calories = json['calories'],
      points = json['points'],
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