import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view/login_screen.dart';
import 'package:savvy/view_model/password_rest_view_model.dart';
import 'package:sizer/sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PasswordResetInputScreen extends ConsumerWidget {
  const PasswordResetInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(passwordRestViewModel);
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController newConfirmPasswordController =
        TextEditingController();

    return Scaffold(
        backgroundColor: AppColors.basicColor,
        appBar: AppBar(
            title: Text(
              'パスワードの設定を',
              style: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
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
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Center(
              child: ListView(
            children: [
              SizedBox(
                width: 100.w,
                child: Container(
                  padding: const EdgeInsets.only(top: 62.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.basicBorderColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '新規バスワード',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/pass.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  controller: newPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '確認のため、もう一度入力',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/pass.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  controller: newConfirmPasswordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 100, right: 100, top: 24, bottom: 36),
                          child: SizedBox(
                            width: 100.w - 200,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.activeColor,
                                minimumSize: Size(80.w, 40),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                              ),
                              onPressed: () async {
                                if (newPasswordController.text !=
                                    newConfirmPasswordController.text) {
                                  var snackBar = const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('パスワードが一致しません。'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  var url = Uri.parse(
                                      '${Constants.baseUrl}api/resetPassword');
                                  var response = await http.post(url,
                                      headers: {
                                        "Content-Type": "application/json"
                                      },
                                      body: jsonEncode({
                                        'email': viewModel.getVerifiedMail,
                                        'password': newPasswordController.text,
                                        'resetPasswordToken':
                                            viewModel.getResetPasswordToken
                                      }));
                                  var parsedJson = jsonDecode(response.body);
                                  if (parsedJson['status'] == 'successful') {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
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
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    });
                                  } else {
                                    var snackBar = const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('エラーが発生しました。'));
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                              child: Text('確認',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.colorWhite,
                                      decoration: TextDecoration.none)),
                            ),
                          )),
                    ],
                  )
                ],
              )
            ],
          ));
        }));
  }
}
