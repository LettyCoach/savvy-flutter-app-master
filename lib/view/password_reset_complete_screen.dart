import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view/password_reset_input_screen.dart';
import 'package:savvy/view_model/password_rest_view_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PasswordResetCompleteScreen extends ConsumerWidget {
  const PasswordResetCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(passwordRestViewModel);

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Image.asset(
                                  'assets/confirm.png',
                                  width: 52,
                                ),
                              ),
                              Text(
                                '送信完了',
                                style: TextStyle(
                                    color: AppColors.colorWhite,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('詳細は、ご登録いただきました',
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16,
                                      height: 1.4)),
                              Text('メールアドレスに送信致します。',
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16,
                                      height: 1.4)),
                              Text('今しばらくお待ちください。',
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16,
                                      height: 1.4)),
                              const SizedBox(
                                height: 50,
                              ),
                              Text('メールに記載のあった認証コードを',
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16,
                                      height: 1.4)),
                              Text('入力してください。',
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16,
                                      height: 1.4)),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      VerificationCode(
                        textStyle: TextStyle(
                            color: AppColors.basicColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                        keyboardType: TextInputType.number,
                        length: 4,
                        fillColor: AppColors.colorWhite,
                        cursorColor: AppColors.basicColor,
                        margin: const EdgeInsets.all(4),
                        onCompleted: (String value) {
                          viewModel.updateVerificationCode(value);
                        },
                        onEditing: (bool value) {
                          viewModel.updateEditingState(value);
                          if (!viewModel.getEditingState) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 100, right: 100, top: 24, bottom: 4),
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
                                var url = Uri.parse(
                                    '${Constants.baseUrl}api/verifyCode');
                                var response = await http.post(url,
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: jsonEncode({
                                      'verifyCode':
                                          viewModel.getVerificationCode,
                                      'email': viewModel.getVerifiedMail
                                    }));

                                if (response.statusCode == 200) {
                                  var parsedJson = jsonDecode(response.body);
                                  if (parsedJson['status'] == 'successful') {
                                    viewModel.updateResetPasswordToken(
                                        parsedJson['resetPasswordToken']);
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PasswordResetInputScreen()),
                                    );
                                  } else if (parsedJson['status'] ==
                                      'invalidEmail') {
                                    var snackBar = const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('メールが正しくありません。'));
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  var snackBar = const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('コードが正しくありません。'));
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text('確認',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.colorWhite,
                                      decoration: TextDecoration.none)),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/redo.png'),
                            const SizedBox(
                              width: 4,
                            ),
                            Text('OTPコードを再送信する。',
                                style: TextStyle(
                                    color: AppColors.colorWhite,
                                    fontSize: 16,
                                    height: 1.4))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ));
        }));
  }
}
