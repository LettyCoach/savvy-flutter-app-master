import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: AppColors.basicColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return ListView(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      height: 60.h,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: Image.asset(
                          'assets/main_logo.png',
                          width: 213,
                        ),
                      )),
                  Container(
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 44),
                          child: Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.activeColor,
                                  minimumSize: Size(80.w, 40),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                                onPressed: () => {context.go('/login')},
                                child: const Text('ログインする',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        decoration: TextDecoration.none)),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 36),
                          child: Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.colorWhite,
                                  minimumSize: Size(80.w, 40),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                                onPressed: () => context.go('/register'),
                                child: Text('新規登録',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.basicColor,
                                        decoration: TextDecoration.none)),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]);
          },
        ),
      );
    });
  }
}
