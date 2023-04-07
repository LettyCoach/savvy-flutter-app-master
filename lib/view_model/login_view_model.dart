import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModel = ChangeNotifierProvider((ref) => LoginViewModel());

enum UserType { buyer, seller }

class LoginViewModel extends ChangeNotifier {
  bool _isLogin = false;
  bool _isRegistered = false;
  bool _obscureText = true;
  String _userType = 'buyer';
  UserType? _loginUserType = UserType.buyer;
  File? _avartaImage;
  bool _isAgree = false;

  // After Logined
  String _userEmail = '';
  String _userFullName = '';
  String _userProfileUrl = '';
  int _userId = 0;

  bool get getLoginState => _isLogin;
  bool get getIsAgreeState => _isAgree;
  File? get getAvartaImage => _avartaImage;
  bool get getRegisterState => _isRegistered;
  bool get getObscureTextState => _obscureText;
  String get getUserType => _userType;

  UserType? get getLoginedUserType => _loginUserType;

  // After Logined
  String get getUserEmail => _userEmail;
  String get getUserFullName => _userFullName;
  String get getUserProfileUrl => _userProfileUrl;
  int get getUserId => _userId;

  void updateIsAgreeState(bool agree) {
    _isAgree = agree;
    notifyListeners();
  }

  void updateLoginState(bool login) {
    _isLogin = login;
    notifyListeners();
  }

  void updateLoginUserType(UserType? loginUserType) {
    _loginUserType = loginUserType;
    notifyListeners();
  }

  void updateUserType(String usertype) {
    _userType = usertype;
    notifyListeners();
  }

  void updateObscureTextState() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void updateRegisterState(bool register) {
    _isRegistered = register;
    notifyListeners();
  }

  void updateAvartaImage(File? avarta) {
    _avartaImage = avarta;
    notifyListeners();
  }

  // After Logined
  void updateUserEmail(String userEmai) {
    _userEmail = userEmai;
    notifyListeners();
  }

  void updateUserFullName(String fullName) {
    _userFullName = fullName;
    notifyListeners();
  }

  void updateUserProfileUrl(String userProfileUrl) {
    _userProfileUrl = userProfileUrl;
    notifyListeners();
  }

  void updateUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }
}
