import 'dart:convert';

import 'package:encrypt/encrypt.dart' as crypt;
import 'package:flutter/material.dart';
import 'package:gym_builder_app/data/models/user_model.dart';
import 'package:gym_builder_app/presentation/navigation/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends ChangeNotifier {
  final key = crypt.Key.fromLength(32);
  final iv = crypt.IV.fromLength(8);
  late final crypt.Encrypter encrypter;
  final SharedPreferences prefs;
  bool _loggedIn = false;

  List _credsToRemember = [];

  List get credsToRemember => _credsToRemember;
  LoginState(this.prefs) {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
    encrypter = crypt.Encrypter(crypt.Salsa20(key));
  }

  UserModel? _user;
  bool get loggedIn => _loggedIn;

  UserModel? get user => _user;

  set loggedIn(bool value) {
    _loggedIn = value;
    prefs.setBool(loggedInKey, value);
    notifyListeners();
  }

  void login(Map<String, dynamic> user) {
    prefs.setString('user', _encryptString(json.encode(user)));
    _user = UserModel.fromJson(user);
    notifyListeners();
  }

  void logout() {
    prefs.remove('user');
  }

  void rememberUser(Map<String, String> creds) {
    final isRemembered = _credsToRemember
        .where(
          (element) =>
              element['email'].toString().toLowerCase() ==
              creds['email']?.toLowerCase(),
        )
        .isNotEmpty;
    if (!isRemembered) {
      _credsToRemember.add(creds);
    }
    prefs.setStringList(
      'creds',
      _credsToRemember
          .map(
            (e) => _encryptString(json.encode(e)),
          )
          .toList(),
    );
  }

  void forgotUser(Map<String, String> creds) {
    _credsToRemember.removeWhere(
      (element) => element['email'] == creds['email'],
    );
    prefs.setStringList(
      'creds',
      _credsToRemember
          .map(
            (e) => _encryptString(json.encode(e)),
          )
          .toList(),
    );
  }

  void checkLoggedIn() {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      _user = UserModel.fromJson(json.decode(_decryptString(userJson)));
    }
    final creds = prefs.getStringList('creds');
    if (creds != null) {
      _credsToRemember = creds
          .map(
            (e) => json.decode(_decryptString(e)),
          )
          .toList();
    }
  }

  String _encryptString(String text) {
    return encrypter.encrypt(text, iv: iv).base64;
  }

  String _decryptString(String text) {
    return encrypter.decrypt(crypt.Encrypted.fromBase64(text), iv: iv);
  }
}
