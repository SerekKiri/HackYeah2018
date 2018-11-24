import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:fitlocker/utils/utils.dart';
import 'package:fitlocker/models/local_app.dart';

Future<List<LocalApp>> getAppList() async {
  await supaPrefs.init();
  var apps = List<String>.from(await platform.invokeMethod('queryPackages'));
  print(apps);
  List<LocalApp> unsortedApps = List<LocalApp>.from(apps.map((String app) {
    var name = app.split(';')[0];
    var packageName = app.split(';')[1];
    var icon = app.split(';')[2];
    var blocked = false;
    try {
      blocked = supaPrefs.getPrefs().getBool(packageName);
    } catch (e) {}
    if (!(blocked is bool)) blocked = false;

    var bytes = Base64Decoder().convert(icon);
    var iconImage = Image.memory(bytes);

    return LocalApp(name, packageName, iconImage, blocked);
  }).toList());

  unsortedApps.sort();
  return unsortedApps;
}