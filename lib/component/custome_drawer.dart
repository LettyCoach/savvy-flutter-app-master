import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModel);

    return Drawer(
      backgroundColor: AppColors.basicColor,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        children: [
          Container(
            padding: const EdgeInsets.only(top: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: viewModel.getUserProfileUrl == ''
                              ? Image.asset('assets/avarta.png')
                              : Image.network(
                                  viewModel.getUserProfileUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      viewModel.getUserFullName,
                      // 'kk',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      viewModel.getUserEmail,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textDeActiveColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    prefs.remove('full_name');
                    prefs.remove('user_type');
                    prefs.remove('user_id');
                    prefs.remove('profile_url');
                    viewModel.updateLoginState(false);
                    // ignore: use_build_context_synchronously
                    context.go('/login');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.listTitleColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'ログアウト',
                      style: TextStyle(
                        color: AppColors.colorWhite,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
              width: 100.w - 40,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '使い方',
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              size: 10,
                              Icons.arrow_back_ios,
                              color: AppColors.colorWhite,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Divider(
                      color: AppColors.drawBorderColor,
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ヘルプ',
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              size: 10,
                              Icons.arrow_back_ios,
                              color: AppColors.colorWhite,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Divider(
                      color: AppColors.drawBorderColor,
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'プライバシーポリシー',
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              size: 10,
                              Icons.arrow_back_ios,
                              color: AppColors.colorWhite,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Divider(
                      color: AppColors.drawBorderColor,
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '利用規約',
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              size: 10,
                              Icons.arrow_back_ios,
                              color: AppColors.colorWhite,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Divider(
                      color: AppColors.drawBorderColor,
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'お問い合わせ',
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              size: 10,
                              Icons.arrow_back_ios,
                              color: AppColors.colorWhite,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Divider(
                      color: AppColors.drawBorderColor,
                      thickness: 1,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'このアプリについて',
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              size: 10,
                              Icons.arrow_back_ios,
                              color: AppColors.colorWhite,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Divider(
                      color: AppColors.drawBorderColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
