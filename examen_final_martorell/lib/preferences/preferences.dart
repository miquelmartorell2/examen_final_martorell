import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
static late SharedPreferences _prefs;

static String _username = '';
static String _password = '';
static bool _login = false;


static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get username{
    return _prefs.getString('username') ?? _username;
  }

  static set username(String value){
    _username = value;
    _prefs.setString('username', value);
  }

  static String get password{
    return _prefs.getString('password') ?? _password;
  }

  static set password(String value){
    _password = value;
    _prefs.setString('password', value);
  }

  static bool get login{
    return _prefs.getBool('login') ?? _login;
  }

  static set login(bool value){
    _login = value;
    _prefs.setBool('login', value);
  }

  


  //S'utilitza per borrar el contingut de sharedpreferences
  static Future<void> clear() async {
    await _prefs.clear();
  }
}