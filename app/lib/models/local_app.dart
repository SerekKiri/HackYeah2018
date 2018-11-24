import 'package:flutter/material.dart';

class LocalApp extends Comparable {
  String name;
  String packageName;
  Image icon;
  bool isBlocked;

  LocalApp(this.name, this.packageName, this.icon, this.isBlocked);

  @override
  int compareTo(other) {
    if (other.name == null || this.name == null) return 0;
    return this.name.compareTo(other.name);
  }
}