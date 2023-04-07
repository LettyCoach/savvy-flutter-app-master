import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordRestViewModel =
    ChangeNotifierProvider((ref) => PasswordRestViewModel());

class PasswordRestViewModel extends ChangeNotifier {
  bool _onEditing = true;
  String _verificationCode = '';
  String _verifiedMail = '';
  String _resetPasswordToken = '';

  bool get getEditingState => _onEditing;
  String get getVerificationCode => _verificationCode;
  String get getVerifiedMail => _verifiedMail;
  String get getResetPasswordToken => _resetPasswordToken;

  void updateEditingState(bool edit) {
    _onEditing = edit;
    notifyListeners();
  }

  void updateVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  void updateVerifiedMail(String mail) {
    _verifiedMail = mail;
    notifyListeners();
  }

  void updateResetPasswordToken(String resetToken) {
    _resetPasswordToken = resetToken;
    notifyListeners();
  }
}
