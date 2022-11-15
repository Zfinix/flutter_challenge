import 'package:flutter_challenge/auth/auth.dart';
import 'package:flutter_challenge/auth/views/auth_pages/create_passcode_page.dart';
import 'package:flutter_challenge/auth/views/main_page/main_page.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const mainPage = 'main';
  static const createAccountPage = 'create_account';
  static const createPasscodePage = 'create_passcode';
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.createAccountPage,
      path: '/',
      builder: (_, __) => const CreateAccountPage(),
    ),
    GoRoute(
      name: Routes.createPasscodePage,
      path: '/${Routes.createPasscodePage}',
      builder: (_, __) => CreatePasscodePage(),
    ),
    GoRoute(
      name: Routes.mainPage,
      path: '/${Routes.mainPage}',
      builder: (_, __) => const MainPage(),
    )
  ],
);
