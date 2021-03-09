import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String UserLoggedInKey = "USERLOGGEDINKEY";

  static saveUserLoggedInDatails({@required bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserLoggedInKey, isLoggedin);
  }

  static Future<bool> getUserLoggedInDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(UserLoggedInKey);
  }

}