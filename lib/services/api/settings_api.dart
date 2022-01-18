import 'dart:convert';

import 'package:mobile_outcastbarber/models/settingsdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsApi {
  static Future<SettingsData> settingsLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('settingsdata') == null) {
      SettingsData settingsdata = SettingsData(1, false, null);
      return settingsdata;
    }
    SettingsData settingsdata = SettingsData.fromjson(jsonDecode(prefs.getString('settingsdata')!));
    return settingsdata;
  }

  static void settingsUpdate(SettingsData settingsData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('settingsdata', (jsonEncode(settingsData.tojson())));
  }
}
