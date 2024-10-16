import 'package:flutter/material.dart';
import 'package:project_se_app/models/prof_auth.dart';

class ProfProvider extends ChangeNotifier {
  Prof? _prof;
  String? _accessToken;
  String? _refreshToken;

  Prof get user => _prof!;
  String get accessToken => _accessToken!;
  String get refreshToken => _refreshToken!;

  void onlogin(ProfModel profModel) {
    _prof = profModel.prof;
    _accessToken = profModel.accessToken;
    _refreshToken = profModel.refreshToken;
    notifyListeners();
  }

  void onlogout() {
    _prof = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  bool isAuthentication() {
    return _accessToken != null && _refreshToken != null;
  }

  void requestToken(String newToken) {
    _accessToken = newToken;
    notifyListeners();
  }
}
