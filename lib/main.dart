import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view/home_screen.dart';
import 'package:savvy/view/login_screen.dart';
import 'package:savvy/view/main_screen.dart';
import 'package:savvy/view/password_reset_complete_screen.dart';
import 'package:savvy/view/password_reset_input_screen.dart';
import 'package:savvy/view/password_reset_screen.dart';
import 'package:savvy/view/profile_edit_screen.dart';
import 'package:savvy/view/register_screen.dart';
import 'package:savvy/view/scan_screen.dart';
import 'package:savvy/view/suppllier/main_screen.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModel.notifier);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        theme: ThemeData(
            primaryColor: AppColors.basicColor,
            // ignore: deprecated_member_use
            backgroundColor: AppColors.basicColor,
            unselectedWidgetColor: Colors.white,
            textTheme: GoogleFonts.notoSansAdlamTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
            )),
        routerConfig: GoRouter(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'login',
                  name: 'login',
                  builder: (BuildContext context, GoRouterState state) {
                    return LoginScreen();
                  },
                ),
                GoRoute(
                  path: 'register',
                  name: 'register',
                  builder: (BuildContext context, GoRouterState state) {
                    return RegisterScreen();
                  },
                ),
                GoRoute(
                  path: 'main',
                  name: 'main',
                  builder: (BuildContext context, GoRouterState state) {
                    return const MainScreen();
                  },
                ),
                GoRoute(
                  path: 'scaner',
                  name: 'scaner',
                  builder: (BuildContext context, GoRouterState state) {
                    return ScannerPage();
                  },
                ),
                GoRoute(
                  path: 'profile_edit',
                  name: 'profile_edit',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ProfileEditScreen();
                  },
                ),
                GoRoute(
                  path: 'password_rest',
                  name: 'password_rest',
                  builder: (BuildContext context, GoRouterState state) {
                    return const PasswordResetScreen();
                  },
                ),
                GoRoute(
                  path: 'password_rest_input',
                  name: 'password_rest_input',
                  builder: (BuildContext context, GoRouterState state) {
                    return const PasswordResetInputScreen();
                  },
                ),
                GoRoute(
                  path: 'password_rest_complete',
                  name: 'password_rest_complete',
                  builder: (BuildContext context, GoRouterState state) {
                    return const PasswordResetCompleteScreen();
                  },
                ),
                GoRoute(
                  path: 'suppllier_main',
                  name: 'suppllier_main',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SPMainScreen();
                  },
                ),
              ],
              redirect: (BuildContext context, GoRouterState state) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? fullName = prefs.getString('full_name');
                String? profileUrl = prefs.getString('profile_url');
                String? userEmail = prefs.getString('email');
                int? userId = prefs.getInt('user_id');
                userEmail == null
                    ? viewModel.updateLoginState(false)
                    : viewModel.updateLoginState(true);
                userEmail == null
                    ? viewModel.updateUserEmail('')
                    : viewModel.updateUserEmail(userEmail);
                fullName == null
                    ? viewModel.updateUserFullName('')
                    : viewModel.updateUserFullName(fullName);
                profileUrl == null
                    ? viewModel.updateUserProfileUrl('')
                    : viewModel.updateUserProfileUrl(profileUrl);
                userId == null
                    ? viewModel.updateUserId(0)
                    : viewModel.updateUserId(userId);

                if (prefs.getString('user_type') != null) {
                  prefs.getString('user_type') == 'buyer'
                      ? viewModel.updateUserType('buyer')
                      : viewModel.updateUserType('seller');
                  prefs.getString('user_type') == 'buyer'
                      ? viewModel.updateLoginUserType(UserType.buyer)
                      : viewModel.updateLoginUserType(UserType.seller);
                }

                if (!viewModel.getLoginState) {
                  if (state.fullpath == '/main') {
                    return '/login';
                  } else {
                    return state.fullpath;
                  }
                } else {
                  if (state.fullpath == '/' ||
                      state.fullpath == '/register' ||
                      state.fullpath == '/login' ||
                      state.fullpath == '/main') {
                    if (viewModel.getUserType == 'buyer') {
                      return '/main';
                    } else {
                      return '/suppllier_main';
                    }
                  }
                  return state.fullpath;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
