import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/custom_extention.dart';
import 'package:savvy/model/user_data.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view/password_reset_screen.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class LoginScreen extends ConsumerWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModel);
    emailController.text = "test@test.com";
    passController.text = "111111";

    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: AppColors.basicColor,
        appBar: AppBar(
            backgroundColor: AppColors.basicColor,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            )),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 240,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/main_logo.png',
                          width: 213,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 80.w,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 28),
                          child: Column(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'メールアドレス',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppColors.colorWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                            SizedBox(
                              height: 36,
                              child: TextField(
                                controller: emailController,
                                style: const TextStyle(fontSize: 12),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(4),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        width: 1, color: AppColors.colorWhite),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: AppColors.colorWhite,
                                          style: BorderStyle.solid)),
                                  filled: true,
                                  fillColor: AppColors.colorWhite,
                                  hintText: 'メールアドレス',
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, bottom: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'パスワード',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AppColors.colorWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                            SizedBox(
                              height: 36,
                              child: TextField(
                                controller: passController,
                                style: const TextStyle(fontSize: 12),
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: viewModel.getObscureTextState,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        viewModel.updateObscureTextState();
                                      },
                                      child: Icon(viewModel.getObscureTextState
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    contentPadding: const EdgeInsets.all(4),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.colorWhite),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: AppColors.colorWhite,
                                            style: BorderStyle.solid)),
                                    filled: true,
                                    fillColor: AppColors.colorWhite,
                                    hintText: '****'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PasswordResetScreen()),
                                      );
                                    },
                                    child: Text('パスワードをお忘れの方',
                                        style: TextStyle(
                                            color: AppColors.deactiveColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                  )),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'あなたは？',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: AppColors.colorWhite,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Radio<UserType>(
                                          value: UserType.buyer,
                                          groupValue:
                                              viewModel.getLoginedUserType,
                                          activeColor: AppColors.colorWhite,
                                          onChanged: (UserType? value) {
                                            viewModel.updateUserType('buyer');
                                            print('buyer');
                                            viewModel
                                                .updateLoginUserType(value);
                                          }),
                                      Expanded(
                                          child: Text(
                                        'バイヤー',
                                        style: TextStyle(
                                            color: AppColors.colorWhite,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Radio<UserType>(
                                          value: UserType.seller,
                                          groupValue:
                                              viewModel.getLoginedUserType,
                                          activeColor: AppColors.colorWhite,
                                          onChanged: (UserType? value) {
                                            viewModel.updateUserType('seller');
                                            print('seller');
                                            viewModel
                                                .updateLoginUserType(value);
                                          }),
                                      Expanded(
                                          child: Text(
                                        'サプライヤー',
                                        style: TextStyle(
                                            color: AppColors.colorWhite,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.activeColor,
                                      minimumSize: Size(60.w, 40),
                                      maximumSize: Size(80.w, 40),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                    ),
                                    onPressed: () async {
                                      bool isEmailValid =
                                          EmailValidationExtention.isValid(
                                              data: emailController.text);
                                      if (isEmailValid) {
                                        var url = Uri.parse(
                                            '${Constants.baseUrl}api/login');
                                        var response = await http.post(url,
                                            headers: {
                                              "Content-Type": "application/json"
                                            },
                                            body: jsonEncode({
                                              'user_type':
                                                  viewModel.getUserType,
                                              'email': emailController.text,
                                              'password': passController.text
                                            }));

                                        var parsedJson =
                                            jsonDecode(response.body);

                                        var loginedUserdata =
                                            User.fromJson(parsedJson);
                                        if (loginedUserdata.status ==
                                            'successful') {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          viewModel.updateUserProfileUrl(
                                              loginedUserdata.profile_url);
                                          viewModel.updateUserEmail(
                                              loginedUserdata.email);
                                          viewModel.updateUserFullName(
                                              loginedUserdata.full_name);
                                          viewModel
                                              .updateUserId(loginedUserdata.id);
                                          prefs.setString(
                                              'email', loginedUserdata.email);
                                          prefs.setString('full_name',
                                              loginedUserdata.full_name);
                                          prefs.setInt(
                                              'user_id', loginedUserdata.id);
                                          prefs.setString('profile_url',
                                              loginedUserdata.profile_url);

                                          prefs.setString('user_type',
                                              viewModel.getUserType);
                                          viewModel.updateLoginState(true);

                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    CircularProgressIndicator(),
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                          Future.delayed(
                                              const Duration(seconds: 1), () {
                                            context.go('/main');
                                          });
                                        } else if (loginedUserdata.status ==
                                            'invalidEmail') {
                                          var snackBar = const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text('ユーザーは存在しません。'));
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (loginedUserdata.status ==
                                            'invalidPassword') {
                                          var snackBar = const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text('パスワードが正しくありません。'));
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          var snackBar = const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text('操作が失敗しました。'));
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      } else {
                                        var snackBar = const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text('メールの形式が正しくありません。'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      // ignore: use_build_context_synchronously
                                    },
                                    child: const Text('ログイン',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            decoration: TextDecoration.none)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'アカウントをお持ちではありませんか?',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.deactiveColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () => context.go('/register'),
                                    child: Text('登録',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.transparent,
                                            shadows: [
                                              Shadow(
                                                  offset: const Offset(0, -2),
                                                  color: AppColors.colorWhite)
                                            ],
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppColors.deactiveColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )
                              ],
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
